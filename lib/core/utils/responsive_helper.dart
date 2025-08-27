import 'package:flutter/material.dart';
import 'package:hamza_portfolio_app/core/constants/app_constants.dart';

class ResponsiveHelper {
  /// -------------------------
  /// Device Type Checks
  /// -------------------------
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < AppConstants.mobileBreakpoint;
  }

  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= AppConstants.mobileBreakpoint &&
        width < AppConstants.tabletBreakpoint;
  }

  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= AppConstants.tabletBreakpoint;
  }

  /// -------------------------
  /// Screen Dimensions
  /// -------------------------
  static double getScreenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;

  static double getScreenHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  /// -------------------------
  /// Padding Helpers
  /// -------------------------
  static double getHorizontalPadding(BuildContext context) {
    final width = getScreenWidth(context);
    // if (width > AppConstants.desktopBreakpoint) return 100;
    if (width > AppConstants.tabletBreakpoint) return 60;
    return 20;
  }

  static EdgeInsets getPagePadding(BuildContext context) {
    return EdgeInsets.symmetric(
      horizontal: isDesktop(context)
          ? AppConstants.extraLargePadding
          : AppConstants.defaultPadding,
      vertical: AppConstants.defaultPadding,
    );
  }

  static EdgeInsets getNavigationPadding(BuildContext context) {
    return EdgeInsets.symmetric(
      horizontal: isDesktop(context)
          ? AppConstants.largePadding
          : AppConstants.defaultPadding,
      vertical: AppConstants.defaultPadding,
    );
  }

  static EdgeInsets getContentPadding(BuildContext context, bool isLarge) {
    return EdgeInsets.all(
      isLarge
          ? AppConstants.largeCardPadding
          : AppConstants.compactCardPadding,
    );
  }

  /// -------------------------
  /// Font Size Helpers
  /// -------------------------
  static double getHeaderFontSize(BuildContext context) {
    final width = getScreenWidth(context);
    // if (width > AppConstants.desktopBreakpoint) return 56;
    if (width > AppConstants.tabletBreakpoint) return 48;
    if (width > AppConstants.mobileBreakpoint) return 36;
    return 28;
  }

  static double getSubtitleFontSize(BuildContext context) {
    final width = getScreenWidth(context);
    if (width > AppConstants.tabletBreakpoint) return 18;
    if (width > AppConstants.mobileBreakpoint) return 16;
    return 14;
  }

  static double getFontSize(BuildContext context, double baseSize) {
    if (isMobile(context)) return baseSize * 0.8;
    return baseSize;
  }

  /// -------------------------
  /// Grid Helpers
  /// -------------------------
  static int getGridCrossAxisCount(BuildContext context) {
    if (isMobile(context)) return 2;
    if (isTablet(context)) return 3;
    return 4;
  }
}
