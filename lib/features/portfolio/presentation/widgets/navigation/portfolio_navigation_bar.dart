import 'package:flutter/material.dart';
import 'package:hamza_portfolio_app/core/constants/app_constants.dart';
import 'package:hamza_portfolio_app/core/constants/app_texts.dart';
import 'package:hamza_portfolio_app/features/portfolio/presentation/widgets/contact/contact_button.dart';
import 'navigation_tab_item.dart';

class PortfolioNavigationBar extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: _buildNavigationContainer(context),
    );
  }

  Widget _buildNavigationContainer(BuildContext context) {
    return AnimatedContainer(
      duration: AppConstants.navigationAnimationDuration,
      padding: EdgeInsets.symmetric(
        horizontal: isDesktopLayout ? 40 : 20,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: hasScrolled
            ? _getScrolledBackgroundColor(context)
            : Colors.transparent,
        boxShadow: _calculateNavigationShadow(context),
        borderRadius: hasScrolled
            ? const BorderRadius.vertical(bottom: Radius.circular(20))
            : null,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildBrandLogo(context),
          isDesktopLayout
              ? _buildDesktopNavigationMenu(context)
              : _buildMobileNavigationMenu(context),
        ],
      ),
    );
  }

  Color _getScrolledBackgroundColor(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return isDark
        ? colorScheme.surface.withOpacity(0.95)
        : colorScheme.surface.withOpacity(0.98);
  }

  List<BoxShadow> _calculateNavigationShadow(BuildContext context) {
    if (!hasScrolled) return [];

    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return [
      BoxShadow(
        color: colorScheme.shadow.withOpacity(isDark ? 0.1 : 0.04),
        blurRadius: 20,
        offset: const Offset(0, 2),
        spreadRadius: 0,
      ),
      BoxShadow(
        color: colorScheme.primary.withOpacity(isDark ? 0.05 : 0.02),
        blurRadius: 10,
        offset: const Offset(0, 1),
        spreadRadius: 0,
      ),
    ];
  }

  Widget _buildBrandLogo(BuildContext context) {
    return GestureDetector(
      onTap: () => onPageChanged(0),
      child: customLogo ?? _buildDefaultLogo(context),
    );
  }

  Widget _buildDefaultLogo(BuildContext context) {
    return Container();
  }

  Widget _buildDesktopNavigationMenu(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        NavigationTabItem(
          label: AppTextContent.navAboutMe,
          tabIndex: 1,
          activeTabIndex: currentPageIndex,
          onTabSelected: onPageChanged,
          icon: Icons.person_outline,
        ),
        const SizedBox(width: 24),
        NavigationTabItem(
          label: AppTextContent.navSkills,
          tabIndex: 2,
          activeTabIndex: currentPageIndex,
          onTabSelected: onPageChanged,
          icon: Icons.code,
        ),
        const SizedBox(width: 24),
        NavigationTabItem(
          label: AppTextContent.navPortfolio,
          tabIndex: 3,
          activeTabIndex: currentPageIndex,
          onTabSelected: onPageChanged,
          icon: Icons.work_outline,
        ),
        const SizedBox(width: 32),
        const ContactButton(),
      ],
    );
  }

  Widget _buildMobileNavigationMenu(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return PopupMenuButton<int>(
      onSelected: onPageChanged,
      position: PopupMenuPosition.under,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: colorScheme.surfaceContainer,
      elevation: 8,
      itemBuilder: (context) => [
        _buildPopupMenuItem(
          1,
          AppTextContent.navAboutMe,
          Icons.person_outline,
          context,
        ),
        _buildPopupMenuItem(2, AppTextContent.navSkills, Icons.code, context),
        _buildPopupMenuItem(
          3,
          AppTextContent.navPortfolio,
          Icons.work_outline,
          context,
        ),
      ],
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerHigh,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: colorScheme.outlineVariant, width: 0.5),
        ),
        child: Icon(Icons.menu_rounded, color: colorScheme.onSurface, size: 24),
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
    final isSelected = currentPageIndex == value;

    return PopupMenuItem(
      value: value,
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: isSelected
                ? colorScheme.primary
                : colorScheme.onSurfaceVariant,
          ),
          const SizedBox(width: 12),
          Text(
            text,
            style: TextStyle(
              color: isSelected ? colorScheme.primary : colorScheme.onSurface,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
