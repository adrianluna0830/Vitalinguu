import 'package:flutter/material.dart';

class GradientBarPainter extends CustomPainter {
  final double value;
  final double containerRadius;

  GradientBarPainter({required this.value, required this.containerRadius});

  @override
  void paint(Canvas canvas, Size size) {
    if (value > 0.01) {
      final height = value * size.height;
      final rect = Rect.fromLTWH(0, size.height - height, size.width, height);

      final double topRadiusValue =
          (height < containerRadius) ? height / 2 : containerRadius;
      final Radius topRadius = Radius.circular(topRadiusValue);
      final Radius bottomRadius = Radius.circular(containerRadius);

      final gradient = Paint()
        ..shader = LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [Colors.blueAccent, Colors.lightBlueAccent],
        ).createShader(rect);

      canvas.drawRRect(
        RRect.fromRectAndCorners(
          rect,
          topLeft: topRadius,
          topRight: topRadius,
          bottomLeft: bottomRadius,
          bottomRight: bottomRadius,
        ),
        gradient,
      );
    }
  }

  @override
  bool shouldRepaint(covariant GradientBarPainter oldDelegate) {
    return oldDelegate.value != value ||
        oldDelegate.containerRadius != containerRadius;
  }
}