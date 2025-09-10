import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SkillModel {
  final String name;
  final Color color;
  final IconData? icon;
  final String? text;
  final String? assetPath; // works for both PNG & SVG
  final String? category;
  final int? proficiency; // 1–5 scale

  const SkillModel({
    required this.name,
    required this.color,
    this.icon,
    this.text,
    this.assetPath,
    this.category,
    this.proficiency,
  });

  // Factory for IconData-based skill
  factory SkillModel.withIcon({
    required String name,
    required Color color,
    required IconData icon,
    String? category,
    int? proficiency,
  }) {
    return SkillModel(
      name: name,
      color: color,
      icon: icon,
      category: category,
      proficiency: proficiency,
    );
  }

  // Factory for Text-based skill
  factory SkillModel.withText({
    required String name,
    required Color color,
    required String text,
    String? category,
    int? proficiency,
  }) {
    return SkillModel(
      name: name,
      color: color,
      text: text,
      category: category,
      proficiency: proficiency,
    );
  }

  // Factory for Asset-based skill (PNG/SVG both)
  factory SkillModel.withAsset({
    required String name,
    required Color color,
    required String assetPath,
    String? category,
    int? proficiency,
  }) {
    return SkillModel(
      name: name,
      color: color,
      assetPath: assetPath,
      category: category,
      proficiency: proficiency,
    );
  }

  // --- Utility ---
  bool get hasIcon => icon != null;
  bool get hasText => text != null && text!.isNotEmpty;
  bool get hasAsset => assetPath != null && assetPath!.isNotEmpty;
  bool get isValid => hasIcon || hasText || hasAsset;

  /// Widget builder for UI
  Widget getWidget({double size = 40}) {
    if (hasIcon) {
      return Icon(icon, color: color, size: size);
    } else if (hasText) {
      return Text(
        text!,
        style: TextStyle(
          fontSize: size * 0.5,
          color: color,
          fontWeight: FontWeight.bold,
        ),
      );
    } else if (hasAsset) {
      if (assetPath!.toLowerCase().endsWith('.svg')) {
        return SvgPicture.asset(
          assetPath!,
          width: size,
          height: size,
        );
      } else {
        return Image.asset(
          assetPath!,
          width: size,
          height: size,
          fit: BoxFit.contain,
        );
      }
    }
    return const SizedBox.shrink();
  }

  @override
  String toString() {
    return 'SkillModel(name: $name, category: $category, proficiency: $proficiency)';
  }
}
