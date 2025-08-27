// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:hamza_portfolio_app/core/constants/app_colors.dart';
import 'package:hamza_portfolio_app/core/constants/app_constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    ));

    // Start animation with delay
    Future.delayed(widget.animationDelay ?? Duration.zero, () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: _buildSkillCard(),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSkillCard() {
    final size = widget.size ?? 120.0;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.identity()
          ..scale(_isHovered ? 1.05 : 1.0),
        // ignore: sized_box_for_whitespace
        child: Container(
          width: size,
          height: size + 40,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon Container
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: size * 0.6,
                height: size * 0.6,
                decoration: BoxDecoration(
                  color: _isHovered
                      ? widget.skill.color.withOpacity(0.2)
                      : widget.skill.color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(
                    _isHovered ? 20 : 16,
                  ),
                  boxShadow: _isHovered
                      ? [
                    BoxShadow(
                      color: widget.skill.color.withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ]
                      : [],
                  border: Border.all(
                    color: _isHovered
                        ? widget.skill.color.withOpacity(0.5)
                        : Colors.transparent,
                    width: 2,
                  ),
                ),
                child: Center(
                  child: _buildSkillIcon(size * 0.35),
                ),
              ),
              const SizedBox(height: 12),

              // Skill Name
              Flexible(
                child: Text(
                  widget.skill.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: _isHovered
                        ? widget.skill.color
                        : Theme.of(context).primaryColor,
                    letterSpacing: 0.5,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              // Proficiency Indicator
              if (widget.skill.proficiency != null) ...[
                const SizedBox(height: 8),
                _buildProficiencyIndicator(),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSkillIcon(double iconSize) {
    if (widget.skill.hasSvg) {
      // SVG Icon
      return SvgPicture.asset(
        widget.skill.svgPath!,
        width: iconSize,
        height: iconSize,
        colorFilter: ColorFilter.mode(
          _isHovered
              ? widget.skill.color
              : widget.skill.color.withOpacity(0.8),
          BlendMode.srcIn,
        ),
      );
    } else if (widget.skill.hasIcon) {
      // Material Icon
      return AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        child: Icon(
          widget.skill.icon,
          color: _isHovered
              ? widget.skill.color
              : widget.skill.color.withOpacity(0.8),
          size: iconSize,
        ),
      );
    } else if (widget.skill.hasText) {
      // Text Icon
      return AnimatedDefaultTextStyle(
        duration: const Duration(milliseconds: 200),
        style: TextStyle(
          color: _isHovered
              ? widget.skill.color
              : widget.skill.color.withOpacity(0.8),
          fontSize: iconSize * 0.4,
          fontWeight: FontWeight.bold,
        ),
        child: Text(widget.skill.text!),
      );
    }

    return const SizedBox.shrink();
  }

  Widget _buildProficiencyIndicator() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(5, (index) {
          final isActive = index < widget.skill.proficiency!;
          return AnimatedContainer(
            duration: Duration(milliseconds: 200 + (index * 50)),
            width: _isHovered ? 6 : 4,
            height: _isHovered ? 6 : 4,
            margin: const EdgeInsets.symmetric(horizontal: 1.5),
            decoration: BoxDecoration(
              color: isActive
                  ? (_isHovered
                  ? widget.skill.color
                  : widget.skill.color.withOpacity(0.8))
                  : widget.skill.color.withOpacity(0.2),
              shape: BoxShape.circle,
              boxShadow: _isHovered && isActive
                  ? [
                BoxShadow(
                  color: widget.skill.color.withOpacity(0.5),
                  blurRadius: 4,
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

// Alternative simpler version without animations
class SimpleSkillItem extends StatelessWidget {
  final SkillModel skill;
  final double size;

  const SimpleSkillItem({
    Key? key,
    required this.skill,
    this.size = 100,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size + 30,
      decoration: BoxDecoration(
        color: skill.color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: skill.color.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icon
          // ignore: sized_box_for_whitespace
          Container(
            width: size * 0.4,
            height: size * 0.4,
            child: _buildIcon(),
          ),
          const SizedBox(height: 8),

          // Name
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              skill.name,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: skill.color,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIcon() {
    if (skill.hasSvg) {
      return SvgPicture.asset(
        skill.svgPath!,
        colorFilter: ColorFilter.mode(
          skill.color,
          BlendMode.srcIn,
        ),
      );
    } else if (skill.hasIcon) {
      return Icon(
        skill.icon,
        color: skill.color,
        size: size * 0.3,
      );
    } else if (skill.hasText) {
      return Center(
        child: Text(
          skill.text!,
          style: TextStyle(
            color: skill.color,
            fontSize: size * 0.15,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }
    return const SizedBox.shrink();
  }
}