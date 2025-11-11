import 'package:flutter/material.dart';

class WireframePainter extends CustomPainter {
  final Color color;

  const WireframePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    _drawWireframeLines(canvas, size, paint);
    _drawCornerBrackets(canvas, size, paint);
  }

  void _drawWireframeLines(Canvas canvas, Size size, Paint paint) {
    // Top lines
    canvas.drawLine(Offset(20, 20), Offset(size.width - 20, 20), paint);
    canvas.drawLine(Offset(20, 40), Offset(size.width - 60, 40), paint);
    canvas.drawLine(Offset(20, 60), Offset(size.width - 40, 60), paint);

    // Bottom lines
    canvas.drawLine(
      Offset(20, size.height - 60),
      Offset(size.width - 20, size.height - 60),
      paint,
    );
    canvas.drawLine(
      Offset(20, size.height - 40),
      Offset(size.width - 80, size.height - 40),
      paint,
    );
    canvas.drawLine(
      Offset(20, size.height - 20),
      Offset(size.width - 50, size.height - 20),
      paint,
    );
  }

  void _drawCornerBrackets(Canvas canvas, Size size, Paint paint) {
    const bracketSize = 20.0;

    // Top-left corner
    canvas.drawLine(Offset(0, 0), Offset(bracketSize, 0), paint);
    canvas.drawLine(Offset(0, 0), Offset(0, bracketSize), paint);

    // Top-right corner
    canvas.drawLine(
      Offset(size.width, 0),
      Offset(size.width - bracketSize, 0),
      paint,
    );
    canvas.drawLine(
      Offset(size.width, 0),
      Offset(size.width, bracketSize),
      paint,
    );

    // Bottom-left corner
    canvas.drawLine(
      Offset(0, size.height),
      Offset(bracketSize, size.height),
      paint,
    );
    canvas.drawLine(
      Offset(0, size.height),
      Offset(0, size.height - bracketSize),
      paint,
    );

    // Bottom-right corner
    canvas.drawLine(
      Offset(size.width, size.height),
      Offset(size.width - bracketSize, size.height),
      paint,
    );
    canvas.drawLine(
      Offset(size.width, size.height),
      Offset(size.width, size.height - bracketSize),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
