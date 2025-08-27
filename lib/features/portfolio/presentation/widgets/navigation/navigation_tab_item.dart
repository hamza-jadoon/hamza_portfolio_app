
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hamza_portfolio_app/core/constants/app_colors.dart';
import 'package:hamza_portfolio_app/core/constants/app_constants.dart';

/// A customizable navigation tab item with Material 3 theming and smooth animations
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
  late AnimationController _pressAnimationController;
  late AnimationController _stateTransitionController;
  late AnimationController _shimmerAnimationController;

  late Animation<double> _pressScaleAnimation;
  late Animation<double> _stateTransitionAnimation;
  late Animation<double> _shimmerProgressAnimation;

  bool _isHovering = false;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _handleInitialActiveState();
  }

  void _initializeAnimations() {
    // Press feedback animation
    _pressAnimationController = AnimationController(
      duration: const Duration(milliseconds: 120),
      vsync: this,
    );
    _pressScaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.97,
    ).animate(CurvedAnimation(
      parent: _pressAnimationController,
      curve: Curves.easeInOutCubic,
    ));

    // State transition animation (hover/active changes)
    _stateTransitionController = AnimationController(
      duration: const Duration(milliseconds: 280),
      vsync: this,
    );
    _stateTransitionAnimation = CurvedAnimation(
      parent: _stateTransitionController,
      curve: Curves.easeInOutCubic,
    );

    // Shimmer animation for active state
    _shimmerAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1800),
      vsync: this,
    );
    _shimmerProgressAnimation = Tween<double>(
      begin: -1.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _shimmerAnimationController,
      curve: Curves.easeInOutSine,
    ));
  }

  void _handleInitialActiveState() {
    if (_isCurrentlyActive) {
      _stateTransitionController.value = 1.0;
      _shimmerAnimationController.repeat();
    }
  }

  @override
  void didUpdateWidget(NavigationTabItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    _handleActiveStateChange(oldWidget);
  }

  void _handleActiveStateChange(NavigationTabItem oldWidget) {
    if (oldWidget.activeTabIndex != widget.activeTabIndex) {
      if (_isCurrentlyActive) {
        _stateTransitionController.forward();
        _shimmerAnimationController.repeat();
      } else {
        _stateTransitionController.reverse();
        _shimmerAnimationController.stop();
      }
    }
  }

  @override
  void dispose() {
    _pressAnimationController.dispose();
    _stateTransitionController.dispose();
    _shimmerAnimationController.dispose();
    super.dispose();
  }

  bool get _isCurrentlyActive => widget.activeTabIndex == widget.tabIndex;

  void _handleTapDown() {
    HapticFeedback.selectionClick();
    _pressAnimationController.forward().then((_) {
      _pressAnimationController.reverse();
    });
    widget.onTabSelected(widget.tabIndex);
  }

  void _handleHoverStart() {
    if (!_isCurrentlyActive) {
      setState(() => _isHovering = true);
      _stateTransitionController.forward();
    }
  }

  void _handleHoverEnd() {
    if (!_isCurrentlyActive) {
      setState(() => _isHovering = false);
      _stateTransitionController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => _handleHoverStart(),
      onExit: (_) => _handleHoverEnd(),
      child: GestureDetector(
        onTap: _handleTapDown,
        child: ScaleTransition(
          scale: _pressScaleAnimation,
          child: AnimatedBuilder(
            animation: Listenable.merge([
              _stateTransitionAnimation,
              _shimmerProgressAnimation,
            ]),
            builder: (context, child) => _buildTabContainer(colorScheme, isDarkMode),
          ),
        ),
      ),
    );
  }

  Widget _buildTabContainer(ColorScheme colorScheme, bool isDarkMode) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: widget.icon != null ? 10 : 12,
        horizontal: widget.icon != null ? 16 : 20,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppConstants.defaultRadius * 2.5),
        color: _calculateBackgroundColor(colorScheme, isDarkMode),
        border: _calculateBorderStyle(colorScheme, isDarkMode),
        boxShadow: _calculateShadowStyle(colorScheme, isDarkMode),
        gradient: _isCurrentlyActive ? _createShimmerGradient(colorScheme, isDarkMode) : null,
      ),
      child: widget.showBadge ? _buildTabWithBadge(colorScheme, isDarkMode) : _buildTabContent(colorScheme, isDarkMode),
    );
  }

  Widget _buildTabWithBadge(ColorScheme colorScheme, bool isDarkMode) {
    return Badge(
      backgroundColor: colorScheme.error,
      child: _buildTabContent(colorScheme, isDarkMode),
    );
  }

  Widget _buildTabContent(ColorScheme colorScheme, bool isDarkMode) {
    if (widget.icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            widget.icon,
            size: 18,
            color: _calculateTextColor(colorScheme, isDarkMode),
          ),
          const SizedBox(width: 8),
          _buildTabText(colorScheme, isDarkMode),
        ],
      );
    }
    return _buildTabText(colorScheme, isDarkMode);
  }

  Widget _buildTabText(ColorScheme colorScheme, bool isDarkMode) {
    return Text(
      widget.label,
      style: TextStyle(
        color: _calculateTextColor(colorScheme, isDarkMode),
        fontWeight: _isCurrentlyActive ? FontWeight.w700 : FontWeight.w500,
        fontSize: AppConstants.mediumFontSize,
        letterSpacing: 0.4,
        height: 1.2,
      ),
    );
  }

  Color _calculateBackgroundColor(ColorScheme colorScheme, bool isDarkMode) {
    if (_isCurrentlyActive) {
      return colorScheme.primaryContainer;
    }

    if (_isHovering || _stateTransitionAnimation.value > 0) {
      final hoverSurface = isDarkMode
          ? colorScheme.surfaceContainerHigh
          : colorScheme.surfaceContainerHighest;
      return Color.lerp(
        colorScheme.surface,
        hoverSurface,
        _stateTransitionAnimation.value,
      )!;
    }

    return isDarkMode ? colorScheme.surfaceContainer : colorScheme.surface;
  }

  Color _calculateTextColor(ColorScheme colorScheme, bool isDarkMode) {
    if (_isCurrentlyActive) {
      return colorScheme.onSurface;
    }

    if (_isHovering || _stateTransitionAnimation.value > 0) {
      return Color.lerp(
        colorScheme.onSurfaceVariant,
        colorScheme.primary,
        _stateTransitionAnimation.value * 0.7,
      )!;
    }

    return colorScheme.onSurfaceVariant;
  }

  Border? _calculateBorderStyle(ColorScheme colorScheme, bool isDarkMode) {
    if (_isCurrentlyActive) {
      return Border.all(
        color: colorScheme.outline.withOpacity(0.5),
        width: 1.2,
      );
    }

    if (_isHovering || _stateTransitionAnimation.value > 0) {
      return Border.all(
        color: Color.lerp(
          Colors.transparent,
          colorScheme.outlineVariant,
          _stateTransitionAnimation.value,
        )!,
        width: 1,
      );
    }

    return Border.all(
      color: colorScheme.outlineVariant.withOpacity(isDarkMode ? 0.25 : 0.15),
      width: 0.5,
    );
  }

  List<BoxShadow> _calculateShadowStyle(ColorScheme colorScheme, bool isDarkMode) {
    if (_isCurrentlyActive) {
      return [
        BoxShadow(
          color: colorScheme.shadow.withOpacity(isDarkMode ? 0.15 : 0.06),
          blurRadius: 16,
          offset: const Offset(0, 4),
          spreadRadius: 0,
        ),
        BoxShadow(
          color: colorScheme.primary.withOpacity(isDarkMode ? 0.08 : 0.04),
          blurRadius: 8,
          offset: const Offset(0, 2),
          spreadRadius: 0,
        ),
      ];
    }

    if (_isHovering || _stateTransitionAnimation.value > 0) {
      final intensity = _stateTransitionAnimation.value;
      return [
        BoxShadow(
          color: colorScheme.shadow.withOpacity(
            intensity * (isDarkMode ? 0.12 : 0.04),
          ),
          blurRadius: 12,
          offset: const Offset(0, 2),
          spreadRadius: 0,
        ),
      ];
    }

    return [
      BoxShadow(
        color: colorScheme.shadow.withOpacity(isDarkMode ? 0.04 : 0.02),
        blurRadius: 4,
        offset: const Offset(0, 1),
        spreadRadius: 0,
      ),
    ];
  }

  LinearGradient? _createShimmerGradient(ColorScheme colorScheme, bool isDarkMode) {
    final shimmerHighlight = colorScheme.onPrimaryContainer.withOpacity(
      isDarkMode ? 0.06 : 0.04,
    );

    return LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      stops: [
        0.0,
        (_shimmerProgressAnimation.value + 1) / 2,
        1.0,
      ],
      colors: [
        Colors.transparent,
        shimmerHighlight,
        Colors.transparent,
      ],
    );
  }
}