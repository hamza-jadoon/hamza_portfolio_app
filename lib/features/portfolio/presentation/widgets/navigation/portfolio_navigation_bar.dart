import 'package:flutter/material.dart';
import 'package:hamza_portfolio_app/contact/contact_button.dart';
import 'package:hamza_portfolio_app/core/constants/app_constants.dart';
import 'package:hamza_portfolio_app/core/constants/app_texts.dart';
import 'navigation_tab_item.dart';

class PortfolioNavigationBar extends StatefulWidget {
  final int currentPageIndex;
  final bool hasScrolled;
  final Function(int) onPageChanged;
  final bool isDesktopLayout;
  final Widget? customLogo;

  const PortfolioNavigationBar({
    super.key,
    required this.currentPageIndex,
    required this.hasScrolled,
    required this.onPageChanged,
    required this.isDesktopLayout,
    this.customLogo,
  });

  @override
  State<PortfolioNavigationBar> createState() => _PortfolioNavigationBarState();
}

class _PortfolioNavigationBarState extends State<PortfolioNavigationBar>
    with TickerProviderStateMixin {
  late AnimationController _backgroundController;
  late AnimationController _logoController;
  late Animation<double> _backgroundAnimation;
  late Animation<double> _logoScaleAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    _backgroundController = AnimationController(
      duration: const Duration(milliseconds: 350),
      vsync: this,
    );

    _logoController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _backgroundAnimation = CurvedAnimation(
      parent: _backgroundController,
      curve: Curves.easeOutCubic,
    );

    _logoScaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeInOutCubic),
    );
  }

  @override
  void didUpdateWidget(PortfolioNavigationBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.hasScrolled != widget.hasScrolled) {
      if (widget.hasScrolled) {
        _backgroundController.forward();
      } else {
        _backgroundController.reverse();
      }
    }
  }

  @override
  void dispose() {
    _backgroundController.dispose();
    _logoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: AnimatedBuilder(
        animation: _backgroundAnimation,
        builder: (context, child) => _buildNavigationContainer(context),
      ),
    );
  }

  Widget _buildNavigationContainer(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: EdgeInsets.only(
        left: widget.isDesktopLayout ? 48 : 24,
        right: widget.isDesktopLayout ? 48 : 24,
        top: MediaQuery.of(context).padding.top + 12,
        bottom: 16,
      ),
      decoration: BoxDecoration(
        color: _calculateBackgroundColor(colorScheme, isDark),
        borderRadius: _calculateBorderRadius(),
        boxShadow: _calculateNavigationShadow(colorScheme, isDark),
        border: _calculateBorder(colorScheme, isDark),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildBrandSection(context),
          widget.isDesktopLayout
              ? _buildDesktopNavigationMenu(context)
              : _buildMobileNavigationMenu(context),
        ],
      ),
    );
  }

  Color _calculateBackgroundColor(ColorScheme colorScheme, bool isDark) {
    if (!widget.hasScrolled) return Colors.transparent;

    final baseColor = isDark
        ? colorScheme.surface.withOpacity(0.92)
        : colorScheme.surface.withOpacity(0.95);

    return Color.lerp(
      Colors.transparent,
      baseColor,
      _backgroundAnimation.value,
    )!;
  }

  BorderRadius? _calculateBorderRadius() {
    if (!widget.hasScrolled) return null;

    return BorderRadius.vertical(
      bottom: Radius.circular(24 * _backgroundAnimation.value),
    );
  }

  Border? _calculateBorder(ColorScheme colorScheme, bool isDark) {
    if (!widget.hasScrolled) return null;

    return Border.all(
      color: Color.lerp(
        Colors.transparent,
        colorScheme.outline.withOpacity(isDark ? 0.12 : 0.08),
        _backgroundAnimation.value,
      )!,
      width: 0.5,
    );
  }

  List<BoxShadow> _calculateNavigationShadow(
    ColorScheme colorScheme,
    bool isDark,
  ) {
    if (!widget.hasScrolled) return [];

    final shadowOpacity = _backgroundAnimation.value;

    return [
      BoxShadow(
        color: colorScheme.shadow.withOpacity(
          shadowOpacity * (isDark ? 0.15 : 0.08),
        ),
        blurRadius: 32,
        offset: const Offset(0, 8),
        spreadRadius: 0,
      ),
      BoxShadow(
        color: colorScheme.primary.withOpacity(
          shadowOpacity * (isDark ? 0.08 : 0.04),
        ),
        blurRadius: 16,
        offset: const Offset(0, 4),
        spreadRadius: 0,
      ),
    ];
  }

  Widget _buildBrandSection(BuildContext context) {
    // ignore: unused_local_variable
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTapDown: (_) => _logoController.forward(),
      onTapUp: (_) {
        _logoController.reverse();
        widget.onPageChanged(0);
      },
      onTapCancel: () => _logoController.reverse(),
      child: ScaleTransition(scale: _logoScaleAnimation),
    );
  }

  Widget _buildDesktopNavigationMenu(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer.withOpacity(0.8),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          NavigationTabItem(
            label: AppTextContent.navAboutMe,
            tabIndex: 1,
            activeTabIndex: widget.currentPageIndex,
            onTabSelected: widget.onPageChanged,
            icon: Icons.person_outline_rounded,
          ),
          const SizedBox(width: 8),
          NavigationTabItem(
            label: AppTextContent.navSkills,
            tabIndex: 2,
            activeTabIndex: widget.currentPageIndex,
            onTabSelected: widget.onPageChanged,
            icon: Icons.code_rounded,
          ),
          const SizedBox(width: 8),
          NavigationTabItem(
            label: AppTextContent.navPortfolio,
            tabIndex: 3,
            activeTabIndex: widget.currentPageIndex,
            onTabSelected: widget.onPageChanged,
            icon: Icons.work_outline_rounded,
          ),
          const SizedBox(width: 12),
          const ContactButton(),
        ],
      ),
    );
  }

  Widget _buildMobileNavigationMenu(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHigh.withOpacity(0.9),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: colorScheme.outline.withOpacity(0.15),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(isDark ? 0.12 : 0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: PopupMenuButton<int>(
        onSelected: widget.onPageChanged,
        position: PopupMenuPosition.under,
        offset: const Offset(0, 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: colorScheme.surfaceContainer,
        elevation: 16,
        shadowColor: colorScheme.shadow.withOpacity(0.2),
        itemBuilder: (context) => [
          _buildPopupMenuItem(
            1,
            AppTextContent.navAboutMe,
            Icons.person_outline_rounded,
            context,
          ),
          _buildPopupMenuItem(
            2,
            AppTextContent.navSkills,
            Icons.code_rounded,
            context,
          ),
          _buildPopupMenuItem(
            3,
            AppTextContent.navPortfolio,
            Icons.work_outline_rounded,
            context,
          ),
        ],
        child: Container(
          padding: const EdgeInsets.all(12),
          child: Stack(
            children: [
              Icon(Icons.menu_rounded, color: colorScheme.onSurface, size: 24),
              if (widget.currentPageIndex > 0)
                Positioned(
                  top: -2,
                  right: -2,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: colorScheme.primary,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  PopupMenuItem<int> _buildPopupMenuItem(
    int value,
    String text,
    IconData icon,
    BuildContext context,
  ) {
    final colorScheme = Theme.of(context).colorScheme;
    final isSelected = widget.currentPageIndex == value;

    return PopupMenuItem(
      value: value,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? colorScheme.primaryContainer.withOpacity(0.5)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: isSelected
                    ? colorScheme.primary.withOpacity(0.1)
                    : colorScheme.surfaceVariant.withOpacity(0.5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                size: 18,
                color: isSelected
                    ? colorScheme.primary
                    : colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  color: isSelected
                      ? colorScheme.primary
                      : colorScheme.onSurface,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  fontSize: 15,
                ),
              ),
            ),
            if (isSelected)
              Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  color: colorScheme.primary,
                  shape: BoxShape.circle,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
