import 'package:flutter/material.dart';
import 'package:hamza_portfolio_app/core/breakpoints/utils/responsive_helper.dart';
import 'package:hamza_portfolio_app/core/constants/app_colors.dart';
import 'package:hamza_portfolio_app/features/portfolio/presentation/pages/sections/header_section.dart';

class PortfolioHeader extends StatelessWidget {
  final Animation<double> fadeAnimation;
  final Animation<Offset> slideAnimation;

  const PortfolioHeader({
    Key? key,
    required this.fadeAnimation,
    required this.slideAnimation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: fadeAnimation,
      child: SlideTransition(
        position: slideAnimation,
        child: Column(
          children: [
            ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                colors: [
                  AppColors.getTextColor(context),
                  AppColors.gradientStart,
                  AppColors.gradientEnd,
                ],
              ).createShader(bounds),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: ResponsiveHelper.isDesktop(context) ? 60 : 20,
                  vertical: 40,
                ),
                child: const Column(
                  children: [
                    SectionHeader(title: 'PORTFOLIO'),
                    // SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
