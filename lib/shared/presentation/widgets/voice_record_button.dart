import 'package:flutter/material.dart';

class VoiceRecordButton extends StatelessWidget {
  final bool grabando;
  final VoidCallback onToggle;
  final VoidCallback onCancel;
  final double recordButtonSize; // <--- nuevo parámetro
  final double resetButtonSize;

  const VoiceRecordButton({
    super.key,
    required this.grabando,
    required this.onToggle,
    required this.onCancel,
    required this.recordButtonSize, 
    required this.resetButtonSize,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: onToggle,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            width: recordButtonSize,
            height: recordButtonSize,
            decoration: BoxDecoration(
              color: grabando ? Colors.red : Colors.green,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Icon(
              grabando ? Icons.stop : Icons.mic,
              color: Colors.white,
              size: recordButtonSize * 0.5, // icono proporcional al tamaño
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.delete, color: Colors.grey),
          onPressed: onCancel,
          iconSize: resetButtonSize,
        )
      ],
    );
  }
}
