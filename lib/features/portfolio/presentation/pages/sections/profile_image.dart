// profile_image.dart
// ignore_for_file: deprecated_member_use, unnecessary_import

import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart' show StatelessWidget;
import 'package:flutter/material.dart';
import 'package:hamza_portfolio_app/core/constants/app_colors.dart';
import 'package:hamza_portfolio_app/core/constants/app_constants.dart';

class ProfileImage extends StatelessWidget {
  final Animation<double> fadeAnimation;
  final Size? size;
  final double? iconSize;
  final BoxFit fit;

  const ProfileImage({
    Key? key,
    required this.fadeAnimation,
    this.size,
    this.iconSize,
     required this.fit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final imageSize = size ?? const Size(300, 400);

    return FadeTransition(
      opacity: fadeAnimation,
      child: Container(
        width: imageSize.width,
        height: imageSize.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppConstants.defaultRadius * 2),
          // color: AppConstants.profileImageColor,
          // boxShadow: AppConstants.profileImageShadow,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppConstants.defaultRadius * 2),
          // child: Image.asset('assets/hamza1.png'),

        ),
      ),
    );
  }
}