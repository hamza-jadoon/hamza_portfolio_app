import 'package:flutter/material.dart';

class ServiceModel {
  final String title;
  final String description;
  final IconData? icon;
  final Color? backgroundColor;
  final VoidCallback? onTap;

  const ServiceModel({
    required this.title,
    required this.description,
    this.icon,
    this.backgroundColor,
    this.onTap,
  });

  factory ServiceModel.standard({
    required String title,
    required String description,
    IconData? icon,
    VoidCallback? onTap,
  }) {
    return ServiceModel(
      title: title,
      description: description,
      icon: icon,
      onTap: onTap,
    );
  }

  bool get isValid => title.isNotEmpty && description.isNotEmpty;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ServiceModel &&
        other.title == title &&
        other.description == description;
  }

  @override
  int get hashCode => title.hashCode ^ description.hashCode;

  @override
  String toString() {
    return 'ServiceModel(title: $title, description: ${description.substring(0, 30)}...)';
  }
}