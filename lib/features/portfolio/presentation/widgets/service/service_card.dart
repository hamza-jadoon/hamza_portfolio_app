import 'package:flutter/material.dart';
import 'package:hamza_portfolio_app/core/constants/app_constants.dart';
import 'package:hamza_portfolio_app/core/breakpoints/app_texts.dart';
import 'package:hamza_portfolio_app/features/portfolio/data/models/services_model.dart';

class ServiceCard extends StatefulWidget {
  final ServiceModel service;

  const ServiceCard({
    Key? key,
    required this.service,
  }) : super(key: key);

  @override
  State<ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<ServiceCard>
    with TickerProviderStateMixin {
  late AnimationController _hoverController;
  late AnimationController _pulseController;
  late AnimationController _iconController;

  late Animation<double> _scaleAnimation;
  late Animation<double> _elevationAnimation;
  late Animation<double> _pulseAnimation;
  late Animation<double> _iconScaleAnimation;
  late Animation<Color?> _backgroundColorAnimation;

  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    // Hover animation controller
    _hoverController = AnimationController(
      duration: const Duration(milliseconds: 280),
      vsync: this,
    );

    // Pulse animation for subtle breathing effect
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    // Icon scale animation
    _iconController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.03,
    ).animate(CurvedAnimation(
      parent: _hoverController,
      curve: Curves.easeOutCubic,
    ));

    _elevationAnimation = CurvedAnimation(
      parent: _hoverController,
      curve: Curves.easeOutCubic,
    );

    _pulseAnimation = Tween<double>(
      begin: 0.98,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));

    _iconScaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.1,
    ).animate(CurvedAnimation(
      parent: _iconController,
      curve: Curves.easeOutCubic,
    ));

    // Start subtle pulse animation
    _pulseController.repeat(reverse: true);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _initializeColorAnimation();
  }

  void _initializeColorAnimation() {
    final colorScheme = Theme.of(context).colorScheme;

    _backgroundColorAnimation = ColorTween(
      begin: colorScheme.surfaceContainer.withOpacity(0.3),
      end: colorScheme.surfaceContainerHighest.withOpacity(0.8),
    ).animate(CurvedAnimation(
      parent: _hoverController,
      curve: Curves.easeOutCubic,
    ));
  }

  @override
  void dispose() {
    _hoverController.dispose();
    _pulseController.dispose();
    _iconController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return MouseRegion(
      onEnter: (_) => _onHover(true),
      onExit: (_) => _onHover(false),
      child: AnimatedBuilder(
        animation: Listenable.merge([
          _hoverController,
          _pulseAnimation,
        ]),
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value * _pulseAnimation.value,
            child: Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: _backgroundColorAnimation.value,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: _isHovered
                      ? colorScheme.primary.withOpacity(0.3)
                      : colorScheme.outline.withOpacity(0.1),
                  width: _isHovered ? 1.5 : 1,
                ),
                boxShadow: _calculateBoxShadow(colorScheme, isDark),
                gradient: _isHovered ? LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    colorScheme.primary.withOpacity(0.03),
                    colorScheme.secondary.withOpacity(0.02),
                    colorScheme.tertiary.withOpacity(0.01),
                  ],
                ) : null,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(colorScheme, isDark),
                  const SizedBox(height: 24),
                  _buildDescription(colorScheme),
                  if (_isHovered) ...[
                    const SizedBox(height: 20),
                    _buildHoverIndicator(colorScheme),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader(ColorScheme colorScheme, bool isDark) {
    return Row(
      children: [
        AnimatedBuilder(
          animation: _iconScaleAnimation,
          child: _buildIconContainer(colorScheme, isDark),
          builder: (context, child) {
            return Transform.scale(
              scale: _iconScaleAnimation.value,
              child: child,
            );
          },
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            widget.service.title,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: colorScheme.onSurface,
              letterSpacing: 0.5,
              height: 1.2,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildIconContainer(ColorScheme colorScheme, bool isDark) {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: _isHovered
              ? [
            colorScheme.primary,
            colorScheme.secondary,
          ]
              : [
            colorScheme.primary.withOpacity(0.8),
            colorScheme.secondary.withOpacity(0.6),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: colorScheme.primary.withOpacity(_isHovered ? 0.3 : 0.15),
            blurRadius: _isHovered ? 12 : 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Icon(
        widget.service.icon ?? _getIconForService(widget.service.title),
        color: colorScheme.onPrimary,
        size: 28,
      ),
    );
  }

  Widget _buildDescription(ColorScheme colorScheme) {
    return Text(
      widget.service.description,
      style: TextStyle(
        fontSize: 16,
        color: colorScheme.onSurface.withOpacity(0.8),
        height: 1.6,
        letterSpacing: 0.2,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Widget _buildHoverIndicator(ColorScheme colorScheme) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 300),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Container(
          height: 3,
          width: 60 * value,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                colorScheme.primary,
                colorScheme.secondary,
                colorScheme.tertiary,
              ],
            ),
            borderRadius: BorderRadius.circular(2),
          ),
        );
      },
    );
  }

  List<BoxShadow> _calculateBoxShadow(ColorScheme colorScheme, bool isDark) {
    final baseOpacity = isDark ? 0.08 : 0.04;
    final hoverMultiplier = _elevationAnimation.value;

    return [
      BoxShadow(
        color: colorScheme.shadow.withOpacity(
          baseOpacity + (hoverMultiplier * baseOpacity * 2),
        ),
        blurRadius: 16 + (hoverMultiplier * 8),
        offset: Offset(0, 6 + (hoverMultiplier * 4)),
        spreadRadius: 0,
      ),
      BoxShadow(
        color: colorScheme.primary.withOpacity(
          baseOpacity * 0.5 + (hoverMultiplier * baseOpacity),
        ),
        blurRadius: 8 + (hoverMultiplier * 4),
        offset: Offset(0, 2 + (hoverMultiplier * 2)),
        spreadRadius: 0,
      ),
    ];
  }

  void _onHover(bool isHovered) {
    setState(() {
      _isHovered = isHovered;
    });

    if (isHovered) {
      _hoverController.forward();
      _iconController.forward();
    } else {
      _hoverController.reverse();
      _iconController.reverse();
    }
  }

  IconData _getIconForService(String title) {
    switch (title.toLowerCase()) {
      case 'design':
        return Icons.palette_rounded;
      case 'development':
        return Icons.code_rounded;
      case 'maintenance':
        return Icons.build_rounded;
      default:
        return Icons.star_rounded;
    }
  }
}