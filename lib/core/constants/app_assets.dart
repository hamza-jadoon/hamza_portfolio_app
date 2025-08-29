class AppAssets {
  // PNG Images
  static const String hamza1png = "assets/images/hamza1.png";
  static const String hamza2png = "assets/images/hamza2.png";
  static const String mentalpng = "assets/images/mental.png";
  static const String bedtimepng = "assets/images/bedtime.png";
  static const String menyoupng = "assets/images/menyou.png";
  static const String prayertimepng = "assets/images/prayertime.png";

  // SVG Icons
  static const String apl = "assets/app_icons/apl-plain.svg";
  static const String dart = "assets/app_icons/dart-original.svg";
  static const String figma = "assets/app_icons/figma-original.svg";
  static const String firebase = "assets/app_icons/firebase-original.svg";
  static const String flutter = "assets/app_icons/flutter-original.svg";
  static const String github = "assets/app_icons/github-original.svg";
  static const String git = "assets/app_icons/git-original.svg";
  static const String react = "assets/app_icons/react-original.svg";
  static const String swift = "assets/app_icons/swift-original.svg";
  static const String kotlin = "assets/app_icons/kotlin-original.svg";
  static const String java = "assets/app_icons/java-original.svg";
  static const String python = "assets/app_icons/python-original.svg";
  static const String androidStudio = "assets/app_icons/androidstudio-original.svg";
  static const String vscode = "assets/app_icons/vscode-original.svg";
  static const String javascript = "assets/app_icons/javascript-original.svg";
  static const String nodejs = "assets/app_icons/nodejs-original.svg";
  static const String html5 = "assets/app_icons/html5-original.svg";
  static const String css3 = "assets/app_icons/css3-original.svg";



  static const String github2 = "assets/app_icons/github.svg";
  static const String linkedin = "assets/app_icons/linkdin.svg";
  static const String vector = "assets/app_icons/Vector.svg";

  static const String defaultSkill = "assets/app_icons/default.svg";



  static String getSkillIcon(String skillName) {
    switch (skillName.toLowerCase()) {
      case 'flutter':
        return flutter;
      case 'dart':
        return dart;
      case 'firebase':
        return firebase;
      case 'git':
        return git;
      case 'github':
        return github;
      case 'vscode':
      case 'vs code':
        return vscode;
      case 'android studio':
        return androidStudio;
      case 'figma':
        return figma;
      case 'javascript':
        return javascript;
      case 'python':
        return python;
      case 'java':
        return java;
      case 'kotlin':
        return kotlin;
      case 'swift':
        return swift;
      case 'react':
        return react;
      default:
        return defaultSkill; // 👈 added default case
    }
  }
}


