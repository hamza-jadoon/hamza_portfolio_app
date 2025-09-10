import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hamza_portfolio_app/core/constants/app_colors.dart';
import 'package:hamza_portfolio_app/core/constants/app_constants.dart';

/// Enhanced navigation tab item matching HomePage design language
class NavigationTabItem extends StatefulWidget {
  final String label;
  final int tabIndex;
  final int activeTabIndex;
  final Function(int) onTabSelected;
  final IconData? icon;
  final bool showBadge;

  const NavigationTabItem({
    super.key,
    required this.label,
    required this.tabIndex,
    required this.activeTabIndex,
    required this.onTabSelected,
    this.icon,
    this.showBadge = false,
  });

  @override
  State<NavigationTabItem> createState() => _NavigationTabItemState();
}

class _NavigationTabItemState extends State<NavigationTabItem>
    with TickerProviderStateMixin {
  late AnimationController _pressController;
  late AnimationController _hoverController;
  late AnimationController _activeController;
  late AnimationController _pulseController;

  late Animation<double> _pressScaleAnimation;
  late Animation<double> _hoverAnimation;
  late Animation<double> _activeAnimation;
  late Animation<double> _pulseAnimation;

  bool _isHovering = false;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _handleInitialState();
  }

  void _initializeAnimations() {
    // Press feedback animation
    _pressController = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
    _pressScaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _pressController,
      curve: Curves.easeInOutCubic,
    ));

    // Hover state animation
    _hoverController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _hoverAnimation = CurvedAnimation(
      parent: _hoverController,
      curve: Curves.easeOutCubic,
    );

    // Active state animation
    _activeController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _activeAnimation = CurvedAnimation(
      parent: _activeController,
      curve: Curves.easeOutCubic,
    );

    // Pulse animation for active state
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _pulseAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));
  }

  void _handleInitialState() {
    if (_isCurrentlyActive) {
      _activeController.value = 1.0;
      _startPulseAnimation();
    }
  }

  void _startPulseAnimation() {
    _pulseController.repeat(reverse: true);
  }

  void _stopPulseAnimation() {
    _pulseController.stop();
    _pulseController.reset();
  }

  @override
  void didUpdateWidget(NavigationTabItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.activeTabIndex != widget.activeTabIndex) {
      if (_isCurrentlyActive) {
        _activeController.forward();
        _startPulseAnimation();
      } else {
        _activeController.reverse();
        _stopPulseAnimation();
      }
    }
  }

  @override
  void dispose() {
    _pressController.dispose();
    _hoverController.dispose();
    _activeController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  bool get _isCurrentlyActive => widget.activeTabIndex == widget.tabIndex;

  void _handleTap() {
    HapticFeedback.lightImpact();
    _pressController.forward().then((_) {
      _pressController.reverse();
    });
    widget.onTabSelected(widget.tabIndex);
  }

  void _handleHoverStart() {
    if (!_isCurrentlyActive) {
      setState(() => _isHovering = true);
      _hoverController.forward();
    }
  }

  void _handleHoverEnd() {
    setState(() => _isHovering = false);
    if (!_isCurrentlyActive) {
      _hoverController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => _handleHoverStart(),
      onExit: (_) => _handleHoverEnd(),
      child: GestureDetector(
        onTap: _handleTap,
        child: ScaleTransition(
          scale: _pressScaleAnimation,
          child: AnimatedBuilder(
            animation: Listenable.merge([
              _hoverAnimation,
              _activeAnimation,
              _pulseAnimation,
            ]),
            builder: (context, child) => _buildTabContainer(colorScheme, isDark),
          ),
        ),
      ),
    );
  }

  Widget _buildTabContainer(ColorScheme colorScheme, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: _calculateBackgroundColor(colorScheme, isDark),
        gradient: _calculateBackgroundGradient(colorScheme, isDark),
        border: _calculateBorder(colorScheme, isDark),
        boxShadow: _calculateShadow(colorScheme, isDark),
      ),
      child: widget.showBadge
          ? _buildTabWithBadge(colorScheme, isDark)
          : _buildTabContent(colorScheme, isDark),
    );
  }

  Widget _buildTabWithBadge(ColorScheme colorScheme, bool isDark) {
    return Badge(
      backgroundColor: colorScheme.error,
      smallSize: 8,
      child: _buildTabContent(colorScheme, isDark),
    );
  }

  Widget _buildTabContent(ColorScheme colorScheme, bool isDark) {
    if (widget.icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildIcon(colorScheme, isDark),
          const SizedBox(width: 8),
          _buildText(colorScheme, isDark),
        ],
      );
    }
    return _buildText(colorScheme, isDark);
  }

  Widget _buildIcon(ColorScheme colorScheme, bool isDark) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: EdgeInsets.all(_isCurrentlyActive ? 2 : 0),
      decoration: _isCurrentlyActive ? BoxDecoration(
        color: colorScheme.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
      ) : null,
      child: Icon(
        widget.icon,
        size: 18,
        color: _calculateTextColor(colorScheme, isDark),
      ),
    );
  }

  Widget _buildText(ColorScheme colorScheme, bool isDark) {
    return Text(
      widget.label,
      style: TextStyle(
        color: _calculateTextColor(colorScheme, isDark),
        fontWeight: _isCurrentlyActive ? FontWeight.w700 : FontWeight.w500,
        fontSize: 14,
        letterSpacing: 0.3,
        height: 1.2,
      ),
    );
  }

  Color? _calculateBackgroundColor(ColorScheme colorScheme, bool isDark) {
    if (_isCurrentlyActive) {
      return Color.lerp(
        colorScheme.primaryContainer.withOpacity(0.8),
        colorScheme.primaryContainer,
        _pulseAnimation.value * 0.3,
      );
    }

    if (_isHovering) {
      return Color.lerp(
        Colors.transparent,
        colorScheme.surfaceContainerHighest.withOpacity(0.6),
        _hoverAnimation.value,
      );
    }

    return Colors.transparent;
  }

  LinearGradient? _calculateBackgroundGradient(ColorScheme colorScheme, bool isDark) {
    if (!_isCurrentlyActive) return null;

    final pulseValue = _pulseAnimation.value;
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        colorScheme.primary.withOpacity(0.05 + (pulseValue * 0.03)),
        colorScheme.secondary.withOpacity(0.03 + (pulseValue * 0.02)),
        colorScheme.tertiary.withOpacity(0.02 + (pulseValue * 0.01)),
      ],
    );
  }

  Color _calculateTextColor(ColorScheme colorScheme, bool isDark) {
    if (_isCurrentlyActive) {
      return colorScheme.primary;
    }

    if (_isHovering) {
      return Color.lerp(
        colorScheme.onSurfaceVariant,
        colorScheme.primary,
        _hoverAnimation.value * 0.8,
      )!;
    }

    return colorScheme.onSurfaceVariant;
  }

  Border? _calculateBorder(ColorScheme colorScheme, bool isDark) {
    if (_isCurrentlyActive) {
      final pulseOpacity = 0.3 + (_pulseAnimation.value * 0.2);
      return Border.all(
        color: colorScheme.primary.withOpacity(pulseOpacity),
        width: 1.5,
      );
    }

    if (_isHovering) {
      return Border.all(
        color: Color.lerp(
          Colors.transparent,
          colorScheme.outlineVariant.withOpacity(0.5),
          _hoverAnimation.value,
        )!,
        width: 1,
      );
    }

    return Border.all(
      color: colorScheme.outlineVariant.withOpacity(isDark ? 0.15 : 0.1),
      width: 0.5,
    );
  }

  List<BoxShadow> _calculateShadow(ColorScheme colorScheme, bool isDark) {
    if (_isCurrentlyActive) {
      final pulseIntensity = 0.1 + (_pulseAnimation.value * 0.05);
      return [
        BoxShadow(
          color: colorScheme.primary.withOpacity(pulseIntensity),
          blurRadius: 16 + (_pulseAnimation.value * 4),
          offset: const Offset(0, 4),
          spreadRadius: 0,
        ),
        BoxShadow(
          color: colorScheme.shadow.withOpacity(isDark ? 0.12 : 0.06),
          blurRadius: 12,
          offset: const Offset(0, 2),
          spreadRadius: 0,
        ),
      ];
    }

    if (_isHovering) {
      return [
        BoxShadow(
          color: colorScheme.shadow.withOpacity(
            _hoverAnimation.value * (isDark ? 0.08 : 0.04),
          ),
          blurRadius: 8,
          offset: const Offset(0, 2),
          spreadRadius: 0,
        ),
      ];
    }

    return [
      BoxShadow(
        color: colorScheme.shadow.withOpacity(isDark ? 0.02 : 0.01),
        blurRadius: 2,
        offset: const Offset(0, 1),
        spreadRadius: 0,
      ),
    ];
  }
}