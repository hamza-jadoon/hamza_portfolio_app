// ignore_for_file: unused_import
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hamza_portfolio_app/core/constants/app_assets.dart';
import 'package:hamza_portfolio_app/core/constants/app_colors.dart';
import 'package:hamza_portfolio_app/core/constants/app_constants.dart';
import 'package:hamza_portfolio_app/core/constants/app_links.dart';
import 'package:hamza_portfolio_app/core/constants/app_texts.dart';
import 'package:hamza_portfolio_app/core/utils/responsive_painter.dart';
import 'package:hamza_portfolio_app/features/shared/widgets/profile_image.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatelessWidget {
  final Animation<double> fadeAnimation;
  final Animation<Offset> slideAnimation;
  // final ScrollController scrollController;

  const HomePage({
    Key? key,
    required this.fadeAnimation,
    required this.slideAnimation,
    // required this.scrollController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = MediaQuery.of(context).size.width;
        final screenHeight = MediaQuery.of(context).size.height;
        final isDesktop = screenWidth > 1024;
        final isTablet = screenWidth > 768 && screenWidth <= 1024;
        final isMobile = screenWidth <= 768;

        return Scaffold(
          body: Stack(
            children: [
              // Background - conditional based on layout
              if (!isMobile)
                CustomPaint(
                  painter: ResponsiveDiagonalBackgroundPainter(
                    leftColor: Theme.of(context).scaffoldBackgroundColor,
                    rightColor: Theme.of(context).primaryColor
                    ,
                    screenWidth: screenWidth,
                    screenHeight: screenHeight,
                    isDesktop: isDesktop,
                    isTablet: isTablet,
                    isMobile: isMobile,
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),

              // Mobile gets solid black background
              if (isMobile)
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Theme.of(context).primaryColor,
                ),

              // Content
              Container(
                constraints: BoxConstraints(
                  minHeight: screenHeight,
                ),
                child: isDesktop
                    ? _buildDesktopLayout(screenWidth, screenHeight)
                    : isTablet
                    ? _buildTabletLayout(context, screenWidth, screenHeight)
                    : _buildMobileLayout(context, screenWidth, screenHeight),
              ),


              // Top logo for mobile (like 'TG' in reference)


              // Mobile menu button (hamburger style like reference)
              if (isMobile)
                Positioned(
                  top: MediaQuery.of(context).padding.top + 25,
                  right: 20,
                  child: GestureDetector(
                    onTap: () {
                      // Handle menu action
                    },
                    child: Column(
                      children: [
                        Container(width: 25, height: 2, color: AppColors.backgroundColor),
                        SizedBox(height: 4),
                        Container(width: 25, height: 2, color: AppColors.backgroundColor),
                        SizedBox(height: 4),
                        Container(width: 25, height: 2, color: AppColors.backgroundColor),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDesktopLayout(double screenWidth, double screenHeight) {
    return Row(
      children: [
        // Left section with text content
        Expanded(
          flex: 1,
          child: Container(
            height: screenHeight,
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.08,
              vertical: screenHeight * 0.1,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildGreeting(fontSize: _getResponsiveFontSize(screenWidth, 24, 20, 18)),
                SizedBox(height: screenHeight * 0.02),
                _buildName(fontSize: _getResponsiveFontSize(screenWidth, 64, 48, 36)),
                SizedBox(height: screenHeight * 0.02),
                _buildTitle(fontSize: _getResponsiveFontSize(screenWidth, 18, 16, 14)),
                SizedBox(height: screenHeight * 0.08),
                _buildSocialIcons(),
              ],
            ),
          ),
        ),
        // Right section with image
        Expanded(
          flex: 1,
          child: SizedBox(
            height: screenHeight,
            child: Stack(
              children: [
                // Center(
                //   child: ProfileImage(
                //     fit: BoxFit.contain,
                //     fadeAnimation: fadeAnimation,
                //     size: Size(
                //       screenWidth * 0.25,
                //       screenHeight * 0.7,
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTabletLayout(BuildContext context, double screenWidth, double screenHeight) {
    return Column(
      children: [
        SizedBox(
          height: screenHeight * 0.5,
          width: double.infinity,
          child: Stack(
            children: [
              Center(
                child: ProfileImage(
                  fit: BoxFit.cover,
                  fadeAnimation: fadeAnimation,
                  size: Size(
                    screenWidth * 0.4,
                    screenHeight * 0.45,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: screenHeight * 0.5,
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.1,
            vertical: screenHeight * 0.05,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildGreeting(fontSize: 22),
              const SizedBox(height: 15),
              _buildName(fontSize: 42),
              const SizedBox(height: 15),
              _buildTitle(fontSize: 16),
              const SizedBox(height: 40),
              _buildSocialIcons(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context, double screenWidth, double screenHeight) {
    return SizedBox(
      height: screenHeight,
      child: Stack(
        children: [
          // Full screen background image (75% of screen)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: screenHeight * 0.25,
            child: Stack(
              children: [
                // Profile image as background
                Positioned.fill(
                  child: ProfileImage(
                    fadeAnimation: fadeAnimation,
                    size: Size(screenWidth, screenHeight * 0.75),
                    fit: BoxFit.cover, // Make it cover the entire area
                  ),
                ),

                // Gradient overlay for text readability
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.3),
                          Colors.black.withOpacity(0.7),
                        ],
                        stops: [0.0, 0.6, 1.0],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Text overlay positioned like in reference image
          Positioned(
            bottom: screenHeight * 0.32,
            left: 30,
            right: 30,
            child: FadeTransition(
              opacity: fadeAnimation,
              child: SlideTransition(
                position: slideAnimation,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildGreeting(fontSize: 18, color: AppColors.backgroundColor),
                    SizedBox(height: 8),
                    _buildName(fontSize: 34, color: AppColors.backgroundColor),
                    SizedBox(height: 8),
                    _buildTitle(fontSize: 15, color: AppColors.backgroundColor),
                  ],
                ),
              ),
            ),
          ),

          // Bottom section with dark background - exactly like reference
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: screenHeight * 0.25,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 35),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Social icons row - styled like reference
                  FadeTransition(
                    opacity: fadeAnimation,
                    child: SlideTransition(
                      position: slideAnimation,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildSocialIcons(),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 25),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  double _getResponsiveFontSize(double screenWidth, double desktop, double tablet, double mobile) {
    if (screenWidth > 1024) return desktop;
    if (screenWidth > 768) return tablet;
    return mobile;
  }

  Widget _buildGreeting({double fontSize = 24, Color? color}) {
    return SlideTransition(
      position: slideAnimation,
      child: FadeTransition(
        opacity: fadeAnimation,
        child: Builder(
          builder: (context) => Text(
            AppTextContent.greeting,
            style: TextStyle(
              fontSize: fontSize,
              color: color ?? Theme.of(context).primaryColor,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildName({double fontSize = 64, Color? color}) {
    return SlideTransition(
      position: slideAnimation,
      child: FadeTransition(
        opacity: fadeAnimation,
        child: Builder(
          builder: (context) {
            return Text(
              AppTextContent.fullName,
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: color ?? Theme.of(context).primaryColor,
                height: 1.1,
              ),
            );
          }
        ),
      ),
    );
  }

  Widget _buildTitle({double fontSize = 18, Color? color}) {
    return SlideTransition(
      position: slideAnimation,
      child: FadeTransition(
        opacity: fadeAnimation,
        child: Builder(
          builder: (context) {
            return Text(
              AppTextContent.jobTitle,
              style: TextStyle(
                fontSize: fontSize,
                color: color ?? Theme.of(context).primaryColor,
                fontWeight: FontWeight.w400,
              ),
            );
          }
        ),
      ),
    );
  }

  Widget _buildSocialIcons() {
    return SlideTransition(
      position: slideAnimation,
      child: FadeTransition(
        opacity: fadeAnimation,
        child: Builder(
          builder: (context) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => _launchURL(AppLinks.email),
                  child: SvgPicture.asset(
                    AppAssets.vector,
                    width: 30,
                    height: 30,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                SizedBox(width: 20),
                GestureDetector(
                  onTap: () => _launchURL(AppLinks.linkedin),
                  child: SvgPicture.asset(
                    AppAssets.linkedin,
                    width: 30,
                    height: 30,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                SizedBox(width: 20),
                GestureDetector(
                  onTap: () => _launchURL(AppLinks.github),
                  child: SvgPicture.asset(
                    AppAssets.github2,
                    width: 30,
                    height: 30,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            );
          }
        ),
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}





