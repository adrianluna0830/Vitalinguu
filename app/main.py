import os
from flask import Flask, request, send_file
from flask_restful import Api, Resource
from google import genai
from google.genai import types
import json
import azure.cognitiveservices.speech as speechsdk
from io import BytesIO
import requests
import wave

GOOGLE_API_KEY = os.getenv("GOOGLE_API_KEY")
AZURE_SUBSCRIPTION_KEY = os.getenv("AZURE_SUBSCRIPTION_KEY")
AZURE_REGION = os.getenv("AZURE_REGION", "eastus2")
AZURE_ENDPOINT = f"https://{AZURE_REGION}.api.cognitive.microsoft.com"

app = Flask(__name__)
api = Api(app)
client = genai.Client(api_key=GOOGLE_API_KEY)

speech_config = speechsdk.SpeechConfig(
    subscription=AZURE_SUBSCRIPTION_KEY,
    region=AZURE_REGION
)

class TextGeneration(Resource):
    def post(self):
        data = request.get_json()
        if not data or "prompt" not in data:
            return {"error": "'prompt' field is required"}, 400

        prompt = data["prompt"]
        if not isinstance(prompt, str) or not prompt.strip():
            return {"error": "'prompt' must be a non-empty string"}, 400

        try:
            response = client.models.generate_content(
                model="gemini-2.5-flash",
                contents=prompt,
                config=types.GenerateContentConfig(
                    thinking_config=types.ThinkingConfig(thinking_budget=0)
                ),
            )

            text = response.text.strip()
            if text.startswith("```json"):
                text = text[7:].strip()
            if text.endswith("```"):
                text = text[:-3].strip()

            return {"response": text}
        except Exception as e:
            return {"error": "Text generation failed", "details": str(e)}, 500



class ChatGeneration(Resource):
    def post(self):
        data = request.get_json()
        history = data.get("history", [])
        if not isinstance(history, list):
            return {"error": "'history' must be a list"}, 400

        gemini_contents = []
        for message in history:
            if "role" not in message or "content" not in message:
                return {"error": "Each message must have 'role' and 'content'"}, 400
            gemini_contents.append(types.Content(
                role=message["role"],
                parts=[types.Part(text=message["content"])]
            ))

        try:
            response = client.models.generate_content(
                model="gemini-2.5-flash",
                contents=gemini_contents
            )
            return {"response": response.text}
        except Exception as e:
            return {"error": "Chat generation failed", "details": str(e)}, 500


class TextToSpeech(Resource):
    def post(self):
        try:
            data = request.get_json()
            if not data or "text" not in data:
                return {"error": "'text' field is required"}, 400
            text = data["text"]
            if not text.strip():
                return {"error": "'text' cannot be empty"}, 400

            voice = data.get("voice", "en-US-AvaMultilingualNeural")
            speech_config.speech_synthesis_voice_name = voice

            synthesizer = speechsdk.SpeechSynthesizer(
                speech_config=speech_config,
                audio_config=None
            )
            result = synthesizer.speak_text_async(text).get()

            if result.reason == speechsdk.ResultReason.SynthesizingAudioCompleted:
                audio_data = result.audio_data
                memory_file = BytesIO(audio_data)
                memory_file.seek(0)
                return send_file(memory_file, mimetype='audio/wav', as_attachment=False, download_name='speech.wav')
            else:
                cancellation_details = result.cancellation_details
                error_msg = f"Reason: {cancellation_details.reason}"
                if cancellation_details.error_details:
                    error_msg += f", Details: {cancellation_details.error_details}"
                return {"error": "Speech synthesis failed", "reason": str(cancellation_details.reason),
                        "details": error_msg}, 500
        except Exception as e:
            return {"error": "Unexpected error", "details": str(e)}, 500


class SSMLToSpeech(Resource):
    def post(self):
        try:
            data = request.get_json()
            if not data or "ssml" not in data:
                return {"error": "'ssml' field is required"}, 400
            ssml = data["ssml"]
            if not ssml.strip():
                return {"error": "'ssml' cannot be empty"}, 400

            synthesizer = speechsdk.SpeechSynthesizer(
                speech_config=speech_config,
                audio_config=None
            )
            result = synthesizer.speak_ssml_async(ssml).get()

            if result.reason == speechsdk.ResultReason.SynthesizingAudioCompleted:
                audio_stream = BytesIO(result.audio_data)
                audio_stream.seek(0)
                return send_file(audio_stream, mimetype='audio/wav', as_attachment=False, download_name='speech.wav')
            else:
                cancellation_details = result.cancellation_details
                error_msg = f"Reason: {cancellation_details.reason}"
                if cancellation_details.error_details:
                    error_msg += f", Details: {cancellation_details.error_details}"
                return {"error": "Speech synthesis failed", "reason": str(cancellation_details.reason),
                        "details": error_msg}, 500
        except Exception as e:
            return {"error": "Unexpected error", "details": str(e)}, 500


class FastTranscription(Resource):
    def _get_wav_duration(self, audio_data):
        """Calculate WAV file duration in seconds from audio data."""
        try:
            # Create a BytesIO object from the audio data
            audio_stream = BytesIO(audio_data)

            # Open the WAV file
            with wave.open(audio_stream, 'rb') as wav_file:
                frames = wav_file.getnframes()
                sample_rate = wav_file.getframerate()
                duration = frames / float(sample_rate)
                return duration
        except Exception:
            # If we can't read the WAV file, return 0 duration
            return 0

    def post(self):
        try:
            audio_data = request.get_data()
            if not audio_data:
                return {"error": "No audio data provided"}, 400

            # File size validation (299 MB = 299 * 1024 * 1024 bytes)
            max_file_size = 299 * 1024 * 1024  # 299 MB in bytes
            file_size = len(audio_data)

            if file_size > max_file_size:
                file_size_mb = file_size / (1024 * 1024)
                return {
                    "error": "File size exceeds maximum limit",
                    "details": f"File size: {file_size_mb:.2f} MB, Maximum allowed: 299 MB"
                }, 413

            # Duration validation (1 hour 59 minutes = 119 minutes = 7140 seconds)
            max_duration = 119 * 60  # 1 hour 59 minutes in seconds
            duration = self._get_wav_duration(audio_data)

            if duration > max_duration:
                duration_minutes = duration / 60
                hours = int(duration_minutes // 60)
                minutes = int(duration_minutes % 60)
                return {
                    "error": "Audio duration exceeds maximum limit",
                    "details": f"Audio duration: {hours}h {minutes}m, Maximum allowed: 1h 59m"
                }, 413

            locale = request.args.get('locale', 'en-US')
            definition = {"locales": [locale]}

            url = f"{AZURE_ENDPOINT}/speechtotext/transcriptions:transcribe?api-version=2024-11-15"

            headers = {
                "Ocp-Apim-Subscription-Key": AZURE_SUBSCRIPTION_KEY
            }

            files = {
                "audio": ("audio.wav", audio_data),
                "definition": (None, json.dumps(definition))
            }

            response = requests.post(url, headers=headers, files=files)
            response.raise_for_status()
            transcription = response.json()

            def ms_to_srt_time(ms: int) -> str:
                hours = ms // 3600000
                ms %= 3600000
                minutes = ms // 60000
                ms %= 60000
                seconds = ms // 1000
                milliseconds = ms % 1000
                return f"{hours:02}:{minutes:02}:{seconds:02},{milliseconds:03}"

            srt_output = []
            for i, phrase in enumerate(transcription.get('phrases', []), start=1):
                start = ms_to_srt_time(phrase['offsetMilliseconds'])
                end = ms_to_srt_time(
                    phrase['offsetMilliseconds'] + phrase['durationMilliseconds']
                )
                text = phrase['text']
                srt_output.append(f"{i}\n{start} --> {end}\n{text}\n")

            srt_content = "\n".join(srt_output)
            srt_bytes = BytesIO(srt_content.encode('utf-8'))
            srt_bytes.seek(0)

            return send_file(
                srt_bytes,
                mimetype='text/plain',
                as_attachment=True,
                download_name='subtitles.srt'
            )

        except requests.exceptions.RequestException as e:
            return {"error": "Azure API request failed", "details": str(e)}, 500
        except Exception as e:
            return {"error": "Unexpected error", "details": str(e)}, 500


class PronunciationAssessment(Resource):
    def post(self):
        try:
            language = request.args.get('language', 'en-US')
            reference_text = request.args.get('reference_text', '')

            audio_data = request.get_data()
            if not audio_data:
                return {"error": "No audio data provided"}, 400

            push_stream = speechsdk.audio.PushAudioInputStream()
            audio_config = speechsdk.audio.AudioConfig(stream=push_stream)
            recognizer = speechsdk.SpeechRecognizer(
                speech_config=speech_config,
                language=language,
                audio_config=audio_config
            )

            pronunciation_config = speechsdk.PronunciationAssessmentConfig(
                reference_text=reference_text,
                grading_system=speechsdk.PronunciationAssessmentGradingSystem.HundredMark,
                granularity=speechsdk.PronunciationAssessmentGranularity.Phoneme,
                enable_miscue=bool(reference_text)
            )
            pronunciation_config.apply_to(recognizer)

            push_stream.write(audio_data)
            push_stream.close()

            result = recognizer.recognize_once()
            if result.reason != speechsdk.ResultReason.RecognizedSpeech:
                error_details = ""
                if hasattr(result, "cancellation_details"):
                    error_details = f"Reason: {result.cancellation_details.reason}"
                    if result.cancellation_details.error_details:
                        error_details += f", Details: {result.cancellation_details.error_details}"
                return {"error": "Speech recognition failed", "reason": str(result.reason),
                        "details": error_details}, 500

            pronunciation_result = speechsdk.PronunciationAssessmentResult(result)
            json_result = result.properties.get(speechsdk.PropertyId.SpeechServiceResponse_JsonResult)
            detailed_result = json.loads(json_result) if json_result else {}

            words_detail = []
            if "NBest" in detailed_result and detailed_result["NBest"]:
                nbest_words = detailed_result["NBest"][0].get("Words", [])
                for word_data in nbest_words:
                    word_accuracy_score = word_data.get("PronunciationAssessment", {}).get("AccuracyScore", 0)
                    if word_accuracy_score <= 90:
                        word_info = {
                            "word": word_data.get("Word", ""),
                            "accuracy_score": word_accuracy_score,
                            "error_type": word_data.get("PronunciationAssessment", {}).get("ErrorType", "None")
                        }
                        phonemes_detail = []
                        if "Phonemes" in word_data:
                            for phoneme in word_data["Phonemes"]:
                                score = phoneme.get("PronunciationAssessment", {}).get("AccuracyScore", 0)
                                if score < 90:
                                    phonemes_detail.append(
                                        {"phoneme": phoneme.get("Phoneme", ""), "accuracy_score": score})
                        word_info["phonemes"] = phonemes_detail
                        words_detail.append(word_info)

            overall_scores = {
                "pronunciation_score": pronunciation_result.pronunciation_score,
                "accuracy_score": pronunciation_result.accuracy_score,
                "fluency_score": pronunciation_result.fluency_score
            }
            if reference_text:
                overall_scores["completeness_score"] = pronunciation_result.completeness_score

            response = {
                "recognized_text": result.text,
                "words": words_detail,
                "overall_scores": overall_scores,
                "language": language,
                "reference_text": reference_text if reference_text else None
            }
            return response

        except Exception as e:
            return {"error": "Pronunciation assessment failed", "details": str(e), "type": type(e).__name__}, 500

@app.route("/health", methods=["GET"])
def health_check():
    return {"status": "ok"}, 200
    
api.add_resource(ChatGeneration, "/chat-generation")
api.add_resource(TextGeneration, "/text-generation")
api.add_resource(TextToSpeech, "/text-to-speech")
api.add_resource(SSMLToSpeech, "/ssml-to-speech")
api.add_resource(FastTranscription, "/fast-transcription")
api.add_resource(PronunciationAssessment, "/pronunciation-assessment")

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=True)