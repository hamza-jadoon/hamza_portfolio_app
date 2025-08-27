import 'package:flutter/material.dart';

class SkillModel {
  final String name;
  final Color color;
  final IconData? icon;
  final String? text;
  final String? svgPath; // Add SVG path support
  final String? category;
  final int? proficiency; // 1-5 scale

  const SkillModel({
    required this.name,
    required this.color,
    this.icon,
    this.text,
    this.svgPath,
    this.category,
    this.proficiency,
  });

  // Factory constructors for common skill types
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

  // New factory constructor for SVG icons
  factory SkillModel.withSvg({
    required String name,
    required Color color,
    required String svgPath,
    String? category,
    int? proficiency,
  }) {
    return SkillModel(
      name: name,
      color: color,
      svgPath: svgPath,
      category: category,
      proficiency: proficiency,
    );
  }

  // Getters for validation
  bool get hasIcon => icon != null;
  bool get hasText => text != null && text!.isNotEmpty;
  bool get hasSvg => svgPath != null && svgPath!.isNotEmpty;
  bool get isValid => hasIcon || hasText || hasSvg;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SkillModel &&
        other.name == name &&
        other.color == color;
  }

  @override
  int get hashCode => name.hashCode ^ color.hashCode;

  @override
  String toString() {
    return 'SkillModel(name: $name, color: $color, '
        'hasIcon: $hasIcon, hasText: $hasText, hasSvg: $hasSvg)';
  }
}