
// Enhanced Custom painter for responsive diagonal background
import 'package:flutter/cupertino.dart';

class ResponsiveDiagonalBackgroundPainter extends CustomPainter {
  final Color leftColor;
  final Color rightColor;
  final double screenWidth;
  final double screenHeight;
  final bool isDesktop;
  final bool isTablet;
  final bool isMobile;

  ResponsiveDiagonalBackgroundPainter({
    required this.leftColor,
    required this.rightColor,
    required this.screenWidth,
    required this.screenHeight,
    required this.isDesktop,
    required this.isTablet,
    required this.isMobile,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    if (isDesktop) {
      // Desktop diagonal split
      _paintDesktopDiagonal(canvas, size, paint);
    } else if (isTablet) {
      // Tablet horizontal split with slight diagonal
      _paintTabletDiagonal(canvas, size, paint);
    } else {
      // Mobile vertical arrangement like in reference image
      _paintMobileDiagonal(canvas, size, paint);
    }
  }

  void _paintDesktopDiagonal(Canvas canvas, Size size, Paint paint) {
    // Draw left side - Light color
    paint.color = leftColor;
    Path leftPath = Path();
    leftPath.moveTo(0, 0);
    leftPath.lineTo(size.width * 0.65, 0);
    leftPath.lineTo(size.width * 0.35, size.height);
    leftPath.lineTo(0, size.height);
    leftPath.close();
    canvas.drawPath(leftPath, paint);

    // Draw right side - Dark color
    paint.color = rightColor;
    Path rightPath = Path();
    rightPath.moveTo(size.width * 0.5, 0);
    rightPath.lineTo(size.width, 0);
    rightPath.lineTo(size.width, size.height);
    rightPath.lineTo(size.width * 0.35, size.height);
    rightPath.close();
    canvas.drawPath(rightPath, paint);
  }

  void _paintTabletDiagonal(Canvas canvas, Size size, Paint paint) {
    // Top section (image area) - Dark
    paint.color = rightColor;
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height * 0.55),
      paint,
    );

    // Bottom section (text area) - Light
    paint.color = leftColor;
    Path bottomPath = Path();
    bottomPath.moveTo(0, size.height * 0.45);
    bottomPath.lineTo(size.width, size.height * 0.55);
    bottomPath.lineTo(size.width, size.height);
    bottomPath.lineTo(0, size.height);
    bottomPath.close();
    canvas.drawPath(bottomPath, paint);
  }

  void _paintMobileDiagonal(Canvas canvas, Size size, Paint paint) {
    // Top section (image area) - Dark like in reference image
    paint.color = rightColor;
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height * 0.7),
      paint,
    );

    // Bottom section with diagonal transition - Light
    paint.color = leftColor;
    Path bottomPath = Path();
    bottomPath.moveTo(0, size.height * 0.6);
    bottomPath.lineTo(size.width, size.height * 0.7);
    bottomPath.lineTo(size.width, size.height);
    bottomPath.lineTo(0, size.height);
    bottomPath.close();
    canvas.drawPath(bottomPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}