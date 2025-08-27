// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class AppColors {
  // Primary App Colors
  static const Color backgroundColor = Color(0xFFF5F5F5);
  static const Color darkBackgroundColor = Color(0xFF000000);
  static const Color textColor = Color(0xFF333333);
  static const Color lightGrayColor = Color(0xFF666666);
  static const Color mediumGrayColor = Color(0xFF999999);
  static const Color accentColor = Color(0xFF667EEA);
  static const Color profileImageColor = Color(0xFF87CEEB);
  static const Color socialIconBgColor = Color(0xFFE0E0E0);
  static const Color primaryColor = Color(0xFF1E1E2E);
  static const Color gradientStart = Color(0xFF667EEA);
  static const Color gradientEnd = Color(0xFF764BA2);
  static const Color cardHoverColor = Color(0xFF3A3A4A);

  // Skills Colors - Current Skills
  static const Color flutterColor = Color(0xFF02569B);
  static const Color dartColor = Color(0xFF0175C2);
  static const Color firebaseColor = Color(0xFF2196F3);
  static const Color apiIntegrationColor = Color(0xFF00BCD4);
  static const Color uiUxColor = Color(0xFFFF6F00);
  static const Color httpColor = Color(0xFF009688);
  static const Color sqfliteColor = Color(0xFF003B57);
  static const Color hiveColor = Color(0xFFFFCA28);
  static const Color githubColor = Color(0xFFF05032);
  static const Color androidStudioColor = Color(0xFF007ACC);

  // Skills Colors - Learning Skills
  static const Color blocColor = Color(0xFF1976D2);
  static const Color dioColor = Color(0xFF4CAF50);
  static const Color getxColor = Color(0xFF9C27B0);
  static const Color nodeJsColor = Color(0xFFE10098);
  static const Color pythonColor = Color(0xFF1976D2);
  static const Color swiftColor = Color(0xFF4CAF50);
  static const Color reactColor = Color(0xFF9C27B0);
  static const Color javaColor = Color(0xFFE10098);

  // Skills Colors - Other Skills
  static const Color html5Color = Color(0xFF012169);
  static const Color cssColor = Color(0xFF01411C);
  static const Color vsCodeColor = Color(0xFF3DDC84);
  static const Color figmaColor = Color(0xFFF24E1E);
  static const Color sharedPrefColor = Color(0xFF795548);
  static const Color javascriptColor = Color(0xFF000000);

  // Light Theme Colors
  static const Color lightPrimary = Color(0xFF667EEA);
  static const Color lightSecondary = Color(0xFF764BA2);
  static const Color lightBackground = Color(0xFFF5F5F5);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightOnPrimary = Color(0xFFFFFFFF);
  static const Color lightOnSecondary = Color(0xFFFFFFFF);
  static const Color lightOnBackground = Color(0xFF333333);
  static const Color lightOnSurface = Color(0xFF333333);
  static const Color lightError = Color(0xFFB00020);

  // Dark Theme Colors
  static const Color darkPrimary = Color(0xFF667EEA);
  static const Color darkSecondary = Color(0xFF764BA2);
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkSurface = Color(0xFF1E1E1E);
  static const Color darkOnPrimary = Color(0xFF000000);
  static const Color darkOnSecondary = Color(0xFF000000);
  static const Color darkOnBackground = Color(0xFFE1E1E1);
  static const Color darkOnSurface = Color(0xFFE1E1E1);
  static const Color darkError = Color(0xFFCF6679);

  // Gradients
  static const LinearGradient logoGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [gradientStart, gradientEnd],
  );

  static const LinearGradient skillGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [flutterColor, dartColor],
  );

  static const LinearGradient darkModeGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [darkSurface, Color(0xFF2A2A2A)],
  );

  // Theme-based color getters
  static Color getBackgroundColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkBackground
        : lightBackground;
  }

  static Color getTextColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkOnBackground
        : lightOnBackground;
  }

  static Color getSurfaceColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkSurface
        : lightSurface;
  }

  static Color getCardColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? Color(0xFF2A2A2A)
        : Color(0xFFFFFFFF);
  }

  static Color getShadowColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? Colors.black.withOpacity(0.5)
        : Colors.black.withOpacity(0.1);
  }

  // Skill color mappings
  static Map<String, Color> skillColors = {
    'FLUTTER': flutterColor,
    'DART': dartColor,
    'FIREBASE': firebaseColor,
    'API INTEGRATION': apiIntegrationColor,
    'UI/UX': uiUxColor,
    'HTTP': httpColor,
    'SQFLITE': sqfliteColor,
    'HIVE': hiveColor,
    'GITHUB': githubColor,
    'ANDROID STUDIO': androidStudioColor,
    'BLOC': blocColor,
    'DIO': dioColor,
    'GETX': getxColor,
    'NODE JS': nodeJsColor,
    'PYTHON': pythonColor,
    'SWIFT': swiftColor,
    'REACT': reactColor,
    'JAVA': javaColor,
    'HTML5': html5Color,
    'CSS': cssColor,
    'VS CODE': vsCodeColor,
    'FIGMA': figmaColor,
    'SHARED PREF': sharedPrefColor,
    'JAVASCRIPT': javascriptColor,
  };

  // Get skill color by name
  static Color getSkillColor(String skillName) {
    return skillColors[skillName.toUpperCase()] ?? accentColor;
  }
}