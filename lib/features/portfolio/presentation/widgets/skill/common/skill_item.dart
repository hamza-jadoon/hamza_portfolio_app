// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:hamza_portfolio_app/core/constants/app_colors.dart';
import 'package:hamza_portfolio_app/core/constants/app_constants.dart';
import 'package:hamza_portfolio_app/features/portfolio/data/models/skill_model.dart';

class SkillItem extends StatefulWidget {
  final SkillModel skill;
  final Duration? animationDelay;
  final double? size;

  const SkillItem({
    Key? key,
    required this.skill,
    this.animationDelay,
    this.size,
  }) : super(key: key);

  @override
  State<SkillItem> createState() => _SkillItemState();
}

class _SkillItemState extends State<SkillItem>
    with TickerProviderStateMixin {
  late AnimationController _mainController;
  late AnimationController _hoverController;
  late AnimationController _pulseController;

  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _hoverScaleAnimation;
  late Animation<double> _pulseAnimation;

  bool _isHovered = false;
  late ColorScheme _colorScheme;

  @override
  void initState() {
    super.initState();

    _mainController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _hoverController = AnimationController(
      duration: const Duration(milliseconds: 280),
      vsync: this,
    );

    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _initializeAnimations();
    _startAnimations();
  }

  void _initializeAnimations() {
    _scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _mainController,
      curve: Curves.elasticOut,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _mainController,
      curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _mainController,
      curve: Curves.easeOutCubic,
    ));

    _hoverScaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.05,
    ).animate(CurvedAnimation(
      parent: _hoverController,
      curve: Curves.easeOutCubic,
    ));

    _pulseAnimation = Tween<double>(
      begin: 0.95,
      end: 1.05,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));
  }

  void _startAnimations() {
    Future.delayed(widget.animationDelay ?? Duration.zero, () {
      if (mounted) {
        _mainController.forward();
      }
    });

    Future.delayed(
      (widget.animationDelay ?? Duration.zero) +
          const Duration(milliseconds: 800),
          () {
        if (mounted) {
          _pulseController.repeat(reverse: true);
        }
      },
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _colorScheme = _getM3ColorScheme();

  }

  ColorScheme _getM3ColorScheme() {
    return ColorScheme.fromSeed(
      seedColor: Theme.of(context).primaryColor,
      brightness: Theme.of(context).brightness,
    );
  }

  void _onHover(bool isHovered) {
    setState(() => _isHovered = isHovered);

    if (isHovered) {
      _hoverController.forward();
    } else {
      _hoverController.reverse();
    }
  }

  @override
  void dispose() {
    _mainController.dispose();
    _hoverController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = widget.size ?? 120.0;

    return AnimatedBuilder(
      animation: Listenable.merge([
        _mainController,
        _hoverController,
        _pulseController,
      ]),
      builder: (context, child) {
        return FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: Transform.scale(
              scale: _scaleAnimation.value,
              child: Transform.scale(
                scale: _pulseAnimation.value,
                child: _buildSkillCard(size),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSkillCard(double size) {
    return MouseRegion(
      onEnter: (_) => _onHover(true),
      onExit: (_) => _onHover(false),
      child: Transform.scale(
        scale: _hoverScaleAnimation.value,
        child: SizedBox(
          width: size,
          height: size + 50,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildEnhancedIconContainer(size),
              const SizedBox(height: 16),
              _buildSkillName(),
              const SizedBox(height: 8),
              if (widget.skill.proficiency != null)
                _buildEnhancedProficiencyIndicator(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEnhancedIconContainer(double size) {
    final containerSize = size * 0.65;

    return Container(
      width: containerSize,
      height: containerSize,
      decoration: BoxDecoration(
        color: _isHovered
            ? widget.skill.color.withOpacity(0.15)
            : _colorScheme.surfaceContainer.withOpacity(0.6),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: _isHovered
              ? widget.skill.color.withOpacity(0.4)
              : _colorScheme.outline.withOpacity(0.15),
          width: _isHovered ? 2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: _isHovered
                ? widget.skill.color.withOpacity(0.2)
                : _colorScheme.shadow.withOpacity(0.08),
            blurRadius: _isHovered ? 25 : 15,
            offset: const Offset(0, 8),
          ),
          if (_isHovered)
            BoxShadow(
              color: widget.skill.color.withOpacity(0.1),
              blurRadius: 40,
              offset: const Offset(0, 16),
            ),
        ],
        gradient: _isHovered
            ? LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            widget.skill.color.withOpacity(0.1),
            widget.skill.color.withOpacity(0.05),
            Colors.transparent,
          ],
        )
            : null,
      ),
      child: Stack(
        children: [
          if (_isHovered)
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  gradient: RadialGradient(
                    colors: [
                      widget.skill.color.withOpacity(0.1),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
          Center(
            child: AnimatedScale(
              duration: const Duration(milliseconds: 200),
              scale: _isHovered ? 1.1 : 1.0,
              child: _buildSkillIcon(containerSize * 0.45),
            ),
          ),
          if (_isHovered)
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: widget.skill.color,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: widget.skill.color.withOpacity(0.5),
                      blurRadius: 8,
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSkillIcon(double iconSize) {
    Color iconColor = _isHovered
        ? widget.skill.color
        : widget.skill.color.withOpacity(0.8);

    if (widget.skill.hasAsset) {
      // ✅ Now using PNG instead of SVG
      return Image.asset(
        widget.skill.assetPath!,
        width: iconSize,
        height: iconSize,
        color: iconColor,
        colorBlendMode: BlendMode.srcIn,
      );
    } else if (widget.skill.hasIcon) {
      return Icon(
        widget.skill.icon,
        color: iconColor,
        size: iconSize,
      );
    } else if (widget.skill.hasText) {
      return Text(
        widget.skill.text!,
        style: TextStyle(
          color: iconColor,
          fontSize: iconSize * 0.35,
          fontWeight: FontWeight.w700,
        ),
      );
    }

    return const SizedBox.shrink();
  }

  Widget _buildSkillName() {
    return AnimatedDefaultTextStyle(
      duration: const Duration(milliseconds: 200),
      style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: _isHovered ? widget.skill.color : _colorScheme.onSurface,
        letterSpacing: 0.3,
        height: 1.3,
      ),
      child: Text(
        widget.skill.name,
        textAlign: TextAlign.center,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildEnhancedProficiencyIndicator() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: _isHovered ? widget.skill.color.withOpacity(0.1) : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        border: _isHovered
            ? Border.all(
          color: widget.skill.color.withOpacity(0.3),
          width: 1,
        )
            : null,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: List.generate(5, (index) {
          final isActive = index < widget.skill.proficiency!;

          return AnimatedContainer(
            duration: Duration(milliseconds: 200 + (index * 50)),
            width: _isHovered ? 7 : 5,
            height: _isHovered ? 7 : 5,
            margin: const EdgeInsets.symmetric(horizontal: 2),
            decoration: BoxDecoration(
              color: isActive
                  ? widget.skill.color.withOpacity(_isHovered ? 1.0 : 0.8)
                  : widget.skill.color.withOpacity(0.2),
              shape: BoxShape.circle,
              boxShadow: _isHovered && isActive
                  ? [
                BoxShadow(
                  color: widget.skill.color.withOpacity(0.6),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ]
                  : [],
            ),
          );
        }),
      ),
    );
  }
}
