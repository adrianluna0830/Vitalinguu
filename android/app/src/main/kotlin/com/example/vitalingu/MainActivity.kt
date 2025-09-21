package com.example.vitalingu

import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.EventChannel
import com.microsoft.cognitiveservices.speech.*
import com.microsoft.cognitiveservices.speech.audio.*

class MainActivity : FlutterActivity() {

    private val CHANNEL_ASSESS = "com.example.vitalingu/pronunciation"
    private var assessEvents: EventChannel.EventSink? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        // 🗣️ MethodChannel para iniciar/parar evaluación
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL_ASSESS)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "startAssessment" -> {
                        val referenceText = call.argument<String>("text") ?: ""
                        val language = call.argument<String>("language") ?: "en-US"
                        val filePath = call.argument<String>("filePath") ?: ""

                        startPronunciationAssessmentFromFile(referenceText, language, filePath)
                        result.success("started")
                    }
                    else -> result.notImplemented()
                }
            }

        // 🗣️ EventChannel para resultados
        EventChannel(flutterEngine.dartExecutor.binaryMessenger, "$CHANNEL_ASSESS/results")
            .setStreamHandler(object : EventChannel.StreamHandler {
                override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                    assessEvents = events
                }

                override fun onCancel(arguments: Any?) {
                    assessEvents = null
                }
            })
    }
private fun startPronunciationAssessmentFromFile(referenceText: String, language: String, filePath: String) {
    try {
        val speechKey = "2U3FsrQxESldiKkb1Xb3eBcgI89kV1Lku7KZJRkrCwGjReSWXE37JQQJ99BIACHYHv6XJ3w3AAAYACOGQiIz"
        val serviceRegion = "eastus2"

        val speechConfig = SpeechConfig.fromSubscription(speechKey, serviceRegion)
        val audioConfig = AudioConfig.fromWavFileInput(filePath)

        val recognizer = SpeechRecognizer(speechConfig, language, audioConfig)

        val pronConfigJson = """
        {
            "referenceText": "$referenceText",
            "gradingSystem": "HundredMark",
            "granularity": "Phoneme",
            "phonemeAlphabet": "IPA",
            "enableMiscue": true,
            "enableProsodyAssessment": true,
            "nBestPhonemeCount": 5
        }
        """.trimIndent()

        val pronConfig = PronunciationAssessmentConfig.fromJson(pronConfigJson)
        pronConfig.applyTo(recognizer)

        val result = recognizer.recognizeOnceAsync().get()
        val jsonResult = result.properties.getProperty(PropertyId.SpeechServiceResponse_JsonResult)

        assessEvents?.success(jsonResult)

        recognizer.close()
        speechConfig.close()
        audioConfig.close()
        pronConfig.close()

    } catch (ex: Exception) {
        ex.printStackTrace()
        assessEvents?.error("ASSESS_ERROR", ex.message, null)
    }
}
}
