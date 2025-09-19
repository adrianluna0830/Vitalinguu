import 'dart:async';
import 'package:flutter/material.dart';
import 'package:record/record.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vitalingu/presentation/widgets/gradient_bar_painter.dart';

class LanguageMainScreen extends StatefulWidget {
  const LanguageMainScreen({super.key});

  @override
  State<LanguageMainScreen> createState() => _LanguageMainScreenState();
}

class _LanguageMainScreenState extends State<LanguageMainScreen> {
  final _recorder = AudioRecorder();
  double _amplitude = 0.0;
  StreamSubscription<Amplitude>? _amplitudeSub;

  static const _minDb = -50.0, _maxDb = 0.0, _smoothing = 0.2;
  static const _visHeight = 400.0, _visWidth = 80.0, _visRadius = 40.0;
  static const _buttonSize = 100.0;

  @override
  void dispose() {
    _amplitudeSub?.cancel();
    _recorder.dispose();
    super.dispose();
  }

  Future<void> _startRecording() async {
    if (!await Permission.microphone.request().isGranted) return;
    final dir = await getTemporaryDirectory();
    await _recorder.start(const RecordConfig(encoder: AudioEncoder.wav), path: "${dir.path}/temp.m4a");

    _amplitudeSub = _recorder.onAmplitudeChanged(const Duration(milliseconds: 25)).listen((a) {
      final normalized = ((a.current - _minDb) / (_maxDb - _minDb)).clamp(0.0, 1.0);
      _amplitude = (1 - _smoothing) * _amplitude + _smoothing * normalized;
      if (mounted) setState(() {});
    });
  }

  Future<void> _stopRecording() async {
    if (await _recorder.isRecording()) await _recorder.stop();
    await _amplitudeSub?.cancel();
    setState(() => _amplitude = 0.0);
  }

  Future<void> _toggleRecording() async {
    if (await _recorder.isRecording()) {
      await _stopRecording();
    } else {
      await _startRecording();
    }
  }

  Widget _buildVisualizer() {
    return Container(
      height: _visHeight,
      width: _visWidth,
      child: CustomPaint(
        painter: GradientBarPainter(value: _amplitude, containerRadius: _visRadius),
      ),
    );
  }

  Widget _buildRecordButton(bool isRecording) {
    return SizedBox(
      width: _buttonSize,
      height: _buttonSize,
      child: FloatingActionButton(
        heroTag: 'record_button',
        onPressed: _toggleRecording,
        child: Icon(isRecording ? Icons.stop_rounded : Icons.mic_rounded, size: _buttonSize * 0.5),
      ),
    );
  }

  Widget _buildResetButton() {
    return IconButton(
      icon: const Icon(Icons.delete_forever_rounded),
      onPressed: _stopRecording,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Language Main Screen")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildVisualizer(),
            const SizedBox(height: 20),
            StreamBuilder<RecordState>(
              stream: _recorder.onStateChanged(),
              builder: (context, snapshot) {
                final isRecording = snapshot.data == RecordState.record;
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildRecordButton(isRecording),
                    if (isRecording) const SizedBox(width: 20),
                    if (isRecording) _buildResetButton(),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
