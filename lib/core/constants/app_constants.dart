
import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppConstants {
  // Animation Durations
  static const Duration fadeAnimationDuration = Duration(milliseconds: 1000);
  static const Duration slideAnimationDuration = Duration(milliseconds: 1200);
  static const Duration navigationAnimationDuration = Duration(milliseconds: 300);
  static const Duration pageTransitionDuration = Duration(milliseconds: 500);

  // Breakpoints
  static const double mobileBreakpoint = 768.0;
  static const double tabletBreakpoint = 1024.0;

  // Spacing
  static const double defaultPadding = 20.0;
  static const double largePadding = 40.0;
  static const double extraLargePadding = 60.0;

  // Border Radius
  static const double defaultRadius = 10.0;
  static const double circularRadius = 25.0;

  // Icon Sizes
  static const double defaultIconSize = 24.0;
  static const double largeIconSize = 40.0;
  static const double extraLargeIconSize = 100.0;

  // Font Sizes
  static const double smallFontSize = 12.0;
  static const double mediumFontSize = 16.0;
  static const double largeFontSize = 24.0;
  static const double extraLargeFontSize = 64.0;

  //potfolio

  static const Duration animationDuration = Duration(milliseconds: 1500);
  static const Duration hoverAnimationDuration = Duration(milliseconds: 200);
  static const Duration repositoryDelay = Duration(milliseconds: 500);

  static const double maxDialogWidth = 800.0;
  static const double dialogHeightFactor = 0.8;

  static const double largeCardPadding = 40.0;
  static const double compactCardPadding = 30.0;

  static const double cardBorderRadius = 20.0;
  static const double mockupBorderRadius = 12.0;

  static const double gridSpacing = 30.0;
  static const double gridMainSpacing = 40.0;

  // Responsive breakpoints
  // static const double desktopBreakpoint = 1200.0;
  // static const double tabletBreakpoint = 800.0;
  // static const double mobileBreakpoint = 600.0;

  // Shadows
  static List<BoxShadow> getDefaultShadow(BuildContext context) => [
    BoxShadow(
      color: AppColors.getShadowColor(context),
      blurRadius: 10,
      offset: const Offset(0, 2),
    ),
  ];

  static List<BoxShadow> getNavigationShadow(BuildContext context) => [
    BoxShadow(
      color: AppColors.getShadowColor(context),
      blurRadius: 20,
      offset: const Offset(0, 2),
    ),
  ];

  static List<BoxShadow> getProfileImageShadow(BuildContext context) => [
    BoxShadow(
      color: Theme.of(context).brightness == Brightness.dark
          ? Colors.black.withOpacity(0.5)
          : Colors.black.withOpacity(0.3),
      blurRadius: 30,
      offset: const Offset(0, 10),
    ),
  ];

  static List<BoxShadow> getCardShadow(BuildContext context) => [
    BoxShadow(
      color: AppColors.getShadowColor(context),
      blurRadius: 8,
      offset: const Offset(0, 4),
    ),
  ];

  static List<BoxShadow> getSkillCardShadow(BuildContext context) => [
    BoxShadow(
      color: Theme.of(context).brightness == Brightness.dark
          ? Colors.black.withOpacity(0.3)
          : Colors.black.withOpacity(0.1),
      blurRadius: 6,
      offset: const Offset(0, 3),
    ),
  ];
}