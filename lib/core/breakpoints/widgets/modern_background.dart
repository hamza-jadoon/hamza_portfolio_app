import 'package:flutter/material.dart';

// Reusable background widget that can be used across all sections
class UniversalBackgroundWidget extends StatefulWidget {
  final Widget child;
  final bool showFloatingShapes;
  final bool forceGradientOnMobile; // For sections where you want gradient even on mobile

  const UniversalBackgroundWidget({
    Key? key,
    required this.child,
    this.showFloatingShapes = true,
    this.forceGradientOnMobile = false,
  }) : super(key: key);

  @override
  State<UniversalBackgroundWidget> createState() => _UniversalBackgroundWidgetState();
}

class _UniversalBackgroundWidgetState extends State<UniversalBackgroundWidget>
    with TickerProviderStateMixin {
  late AnimationController _floatController;
  late Animation<double> _floatAnimation;

  @override
  void initState() {
    super.initState();

    _floatController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat(reverse: true);

    _floatAnimation = Tween<double>(begin: -10, end: 10).animate(
      CurvedAnimation(parent: _floatController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _floatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = MediaQuery.of(context).size.width;
        final screenHeight = MediaQuery.of(context).size.height;
        final isDesktop = screenWidth > 1024;
        final isTablet = screenWidth > 768 && screenWidth <= 1024;
        final isMobile = screenWidth <= 768;

        return Stack(
          children: [
            // Animated background
            _buildAnimatedBackground(
              screenWidth,
              screenHeight,
              isDesktop,
              isTablet,
              isMobile,
            ),

            // Floating geometric shapes (optional)
            if (widget.showFloatingShapes)
              _buildFloatingShapes(screenWidth, screenHeight),

            // Main content
            widget.child,
          ],
        );
      },
    );
  }

  Widget _buildAnimatedBackground(
      double screenWidth,
      double screenHeight,
      bool isDesktop,
      bool isTablet,
      bool isMobile,
      ) {
    // For mobile, use gradient unless it's a section that needs custom background
    if (isMobile && !widget.forceGradientOnMobile) {
      return Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.primary.withOpacity(0.8),
              Theme.of(context).colorScheme.secondary,
            ],
          ),
        ),
      );
    }

    return AnimatedBuilder(
      animation: _floatAnimation,
      builder: (context, child) {
        return CustomPaint(
          painter: ModernBackgroundPainter(
            primaryColor: Theme.of(context).colorScheme.primary,
            secondaryColor: Theme.of(context).colorScheme.secondary,
            tertiaryColor: Theme.of(context).colorScheme.tertiary,
            surfaceColor: Theme.of(context).colorScheme.surface,
            screenWidth: screenWidth,
            screenHeight: screenHeight,
            animationValue: _floatAnimation.value,
            isDesktop: isDesktop,
            isTablet: isTablet,
          ),
          child: SizedBox(width: double.infinity, height: double.infinity),
        );
      },
    );
  }

  Widget _buildFloatingShapes(double screenWidth, double screenHeight) {
    return AnimatedBuilder(
      animation: _floatAnimation,
      builder: (context, child) {
        return Stack(
          children: [
            // Floating circle 1
            Positioned(
              top: screenHeight * 0.1 + _floatAnimation.value,
              right: screenWidth * 0.1,
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).colorScheme.tertiary.withOpacity(0.1),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.tertiary.withOpacity(0.3),
                    width: 2,
                  ),
                ),
              ),
            ),
            // Floating square
            Positioned(
              bottom: screenHeight * 0.3 - _floatAnimation.value * 0.5,
              left: screenWidth * 0.05,
              child: Transform.rotate(
                angle: _floatAnimation.value * 0.02,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
                    border: Border.all(
                      color: Theme.of(context).colorScheme.secondary.withOpacity(0.3),
                      width: 2,
                    ),
                  ),
                ),
              ),
            ),
            // Floating triangle-like shape
            Positioned(
              top: screenHeight * 0.6 + _floatAnimation.value * 0.7,
              right: screenWidth * 0.2,
              child: Transform.rotate(
                angle: -_floatAnimation.value * 0.01,
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: LinearGradient(
                      colors: [
                        Theme.of(context).colorScheme.primary.withOpacity(0.1),
                        Theme.of(context).colorScheme.secondary.withOpacity(0.1),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

// Updated ModernBackgroundPainter for consistency
class ModernBackgroundPainter extends CustomPainter {
  final Color primaryColor;
  final Color secondaryColor;
  final Color tertiaryColor;
  final Color surfaceColor;
  final double screenWidth;
  final double screenHeight;
  final double animationValue;
  final bool isDesktop;
  final bool isTablet;

  ModernBackgroundPainter({
    required this.primaryColor,
    required this.secondaryColor,
    required this.tertiaryColor,
    required this.surfaceColor,
    required this.screenWidth,
    required this.screenHeight,
    required this.animationValue,
    required this.isDesktop,
    required this.isTablet,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Background gradient - same as home section
    final gradientPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          surfaceColor,
          primaryColor.withOpacity(0.05),
          secondaryColor.withOpacity(0.03),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      gradientPaint,
    );

    if (isDesktop) {
      // Modern geometric shapes for desktop
      _drawFloatingCircles(canvas, size);
      _drawDiagonalElements(canvas, size);
    }
  }

  void _drawFloatingCircles(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    // Large background circle
    paint.color = primaryColor.withOpacity(0.08);
    canvas.drawCircle(
      Offset(
        size.width * 0.8 + animationValue * 2,
        size.height * 0.3 - animationValue,
      ),
      120 + animationValue * 5,
      paint,
    );

    // Medium circle
    paint.color = secondaryColor.withOpacity(0.06);
    canvas.drawCircle(
      Offset(
        size.width * 0.9 - animationValue,
        size.height * 0.7 + animationValue * 0.5,
      ),
      80 + animationValue * 3,
      paint,
    );

    // Small accent circle
    paint.color = tertiaryColor.withOpacity(0.1);
    canvas.drawCircle(
      Offset(
        size.width * 0.75 + animationValue * 1.5,
        size.height * 0.15 + animationValue,
      ),
      40 + animationValue * 2,
      paint,
    );
  }

  void _drawDiagonalElements(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = primaryColor.withOpacity(0.03);

    final path = Path();
    path.moveTo(size.width * 0.6, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height * 0.4 + animationValue * 10);
    path.lineTo(size.width * 0.7 + animationValue * 5, size.height * 0.2);
    path.close();

    canvas.drawPath(path, paint);

    // Secondary diagonal element
    final paint2 = Paint()
      ..style = PaintingStyle.fill
      ..color = secondaryColor.withOpacity(0.02);

    final path2 = Path();
    path2.moveTo(size.width * 0.8 - animationValue * 3, size.height * 0.6);
    path2.lineTo(size.width, size.height * 0.5 + animationValue * 8);
    path2.lineTo(size.width, size.height);
    path2.lineTo(size.width * 0.9 + animationValue * 2, size.height);
    path2.close();

    canvas.drawPath(path2, paint2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}