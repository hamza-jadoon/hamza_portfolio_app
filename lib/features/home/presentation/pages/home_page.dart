// ignore_for_file: unused_import
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hamza_portfolio_app/core/constants/app_assets.dart';
import 'package:hamza_portfolio_app/core/constants/app_colors.dart';
import 'package:hamza_portfolio_app/core/constants/app_constants.dart';
import 'package:hamza_portfolio_app/core/constants/app_links.dart';
import 'package:hamza_portfolio_app/core/constants/app_texts.dart';
import 'package:hamza_portfolio_app/features/shared/widgets/modern_background.dart';
import 'package:hamza_portfolio_app/features/shared/widgets/profile_image.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  final Animation<double> fadeAnimation;
  final Animation<Offset> slideAnimation;

  const HomePage({
    Key? key,
    required this.fadeAnimation,
    required this.slideAnimation,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _floatController;
  late AnimationController _socialController;
  late Animation<double> _pulseAnimation;
  late Animation<double> _floatAnimation;
  late Animation<Offset> _socialSlideAnimation;

  @override
  void initState() {
    super.initState();

    // Pulse animation for profile image
    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    // Float animation for background elements
    _floatController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat(reverse: true);

    _floatAnimation = Tween<double>(begin: -10, end: 10).animate(
      CurvedAnimation(parent: _floatController, curve: Curves.easeInOut),
    );

    // Staggered animation for social icons
    _socialController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _socialSlideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.5), end: Offset.zero).animate(
          CurvedAnimation(parent: _socialController, curve: Curves.elasticOut),
        );

    // Start social animation with delay
    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) _socialController.forward();
    });
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _floatController.dispose();
    _socialController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = MediaQuery.of(context).size.width;
        final screenHeight = MediaQuery.of(context).size.height;
        final isDesktop = screenWidth > 1024;
        final isTablet = screenWidth > 768 && screenWidth <= 1024;
        final isMobile = screenWidth <= 768;

        return Theme(
          data: Theme.of(
            context,
          ).copyWith(colorScheme: _getM3ColorScheme(context)),
          child: Scaffold(
            backgroundColor: Theme.of(context).colorScheme.surface,
            body: Stack(
              children: [
                // Animated background
                _buildAnimatedBackground(
                  screenWidth,
                  screenHeight,
                  isDesktop,
                  isTablet,
                  isMobile,
                ),

                // Floating geometric shapes
                _buildFloatingShapes(screenWidth, screenHeight),

                // Main content
                Container(
                  constraints: BoxConstraints(minHeight: screenHeight),
                  child: isDesktop
                      ? _buildDesktopLayout(screenWidth, screenHeight)
                      : isTablet
                      ? _buildTabletLayout(context, screenWidth, screenHeight)
                      : _buildMobileLayout(context, screenWidth, screenHeight),
                ),

                // App bar overlay for mobile
                if (isMobile) _buildMobileAppBar(context),
              ],
            ),
          ),
        );
      },
    );
  }

  ColorScheme _getM3ColorScheme(BuildContext context) {
    return ColorScheme.fromSeed(
      seedColor: Theme.of(context).primaryColor,
      brightness: Theme.of(context).brightness,
    );
  }

  Widget _buildAnimatedBackground(
    double screenWidth,
    double screenHeight,
    bool isDesktop,
    bool isTablet,
    bool isMobile,
  ) {
    if (isMobile) {
      return Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.primary.withOpacity(0.8),
              Theme.of(context).colorScheme.secondary,
            ],
          ),
        ),
      );
    }

    return AnimatedBuilder(
      animation: _floatAnimation,
      builder: (context, child) {
        return CustomPaint(
          painter: ModernBackgroundPainter(
            primaryColor: Theme.of(context).colorScheme.primary,
            secondaryColor: Theme.of(context).colorScheme.secondary,
            tertiaryColor: Theme.of(context).colorScheme.tertiary,
            surfaceColor: Theme.of(context).colorScheme.surface,
            screenWidth: screenWidth,
            screenHeight: screenHeight,
            animationValue: _floatAnimation.value,
            isDesktop: isDesktop,
            isTablet: isTablet,
          ),
          child: SizedBox(width: double.infinity, height: double.infinity),
        );
      },
    );
  }

  Widget _buildFloatingShapes(double screenWidth, double screenHeight) {
    return AnimatedBuilder(
      animation: _floatAnimation,
      builder: (context, child) {
        return Stack(
          children: [
            // Floating circle 1
            Positioned(
              top: screenHeight * 0.1 + _floatAnimation.value,
              right: screenWidth * 0.1,
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(
                    context,
                  ).colorScheme.tertiary.withOpacity(0.1),
                  border: Border.all(
                    color: Theme.of(
                      context,
                    ).colorScheme.tertiary.withOpacity(0.3),
                    width: 2,
                  ),
                ),
              ),
            ),
            // Floating square
            Positioned(
              bottom: screenHeight * 0.3 - _floatAnimation.value * 0.5,
              left: screenWidth * 0.05,
              child: Transform.rotate(
                angle: _floatAnimation.value * 0.02,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Theme.of(
                      context,
                    ).colorScheme.secondary.withOpacity(0.1),
                    border: Border.all(
                      color: Theme.of(
                        context,
                      ).colorScheme.secondary.withOpacity(0.3),
                      width: 2,
                    ),
                  ),
                ),
              ),
            ),
            // Floating triangle-like shape
            Positioned(
              top: screenHeight * 0.6 + _floatAnimation.value * 0.7,
              right: screenWidth * 0.2,
              child: Transform.rotate(
                angle: -_floatAnimation.value * 0.01,
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: LinearGradient(
                      colors: [
                        Theme.of(context).colorScheme.primary.withOpacity(0.1),
                        Theme.of(
                          context,
                        ).colorScheme.secondary.withOpacity(0.1),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildMobileAppBar(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 15,
      left: 20,
      right: 20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo or initials
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.white.withOpacity(0.2),
                width: 1,
              ),
            ),
            // child: Text(
            //   'HM', // Using initials as logo
            //   style: TextStyle(
            //     color: Colors.white,
            //     fontWeight: FontWeight.bold,
            //     fontSize: 16,
            //   ),
            // ),
          ),
          // Menu button with modern design
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.white.withOpacity(0.2),
                width: 1,
              ),
            ),
            child: GestureDetector(
              onTap: () {
                // Handle menu action
              },
              child: Icon(Icons.menu_rounded, color: Colors.white, size: 24),
            ),
          ),
        ],
      ),
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
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildGreeting(
                    fontSize: _getResponsiveFontSize(screenWidth, 28, 24, 20),
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  _buildName(
                    fontSize: _getResponsiveFontSize(screenWidth, 72, 56, 42),
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  _buildTitle(
                    fontSize: _getResponsiveFontSize(screenWidth, 20, 18, 16),
                  ),
                  SizedBox(height: screenHeight * 0.05),
                  _buildDescription(),
                  SizedBox(height: screenHeight * 0.08),
                  _buildSocialIcons(isDesktop: true),
                  SizedBox(height: screenHeight * 0.05),
                  _buildCTAButtons(),
                ],
              ),
            ),
          ),
        ),
        // Right section with image and decorative elements
        Expanded(
          flex: 1,
          child: SizedBox(
            height: screenHeight,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Profile image (positioned behind the circle)
                AnimatedBuilder(
                  animation: _pulseAnimation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: 0.95 + (_pulseAnimation.value * 0.05),
                      child: Container(
                        width: screenWidth * 0.30,
                        height: screenWidth * 0.30,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Theme.of(
                                context,
                              ).colorScheme.primary.withOpacity(0.3),
                              blurRadius: 30,
                              offset: const Offset(0, 15),
                            ),
                          ],
                        ),
                        child: ClipOval(
                          child: SizedBox(
                            width: screenWidth * 0.30,
                            height: screenWidth * 0.30,
                            child: ModernProfileImage(
                              fadeAnimation: widget.fadeAnimation,
                              size: Size(
                                screenWidth * 0.30,
                                screenWidth * 0.30,
                              ),
                              fit: BoxFit.cover,
                              images: [AppAssets.hamza22png],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                // Pulsing circle background (positioned on top of the image)
                AnimatedBuilder(
                  animation: _pulseAnimation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: 0.95 + (_pulseAnimation.value * 0.05),
                      child: Container(
                        width: screenWidth * 0.35,
                        height: screenWidth * 0.35,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Theme.of(
                                context,
                              ).colorScheme.primary.withOpacity(0.3),
                              blurRadius: 25,
                              offset: const Offset(0, 12),
                            ),
                          ],
                        ),
                        child: ModernProfileImage(
                          fadeAnimation: widget.fadeAnimation,
                          size: Size(screenWidth * 0.30, screenWidth * 0.30),
                          fit: BoxFit.cover,
                          isDesktop: true,
                          isTablet: false,
                          images: [AppAssets.hamza22png],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTabletLayout(
    BuildContext context,
    double screenWidth,
    double screenHeight,
  ) {
    return SingleChildScrollView(
      child: Column(
        children: [

          SizedBox(
            height: screenHeight ,
            width: double.infinity,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Background gradient
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Theme.of(context).colorScheme.surface,
                        Theme.of(context).colorScheme.primary.withOpacity(0.05),
                      ],
                    ),
                  ),
                ),
                // Profile image
                AnimatedBuilder(
                  animation: _pulseAnimation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: 0.95 + (_pulseAnimation.value * 0.05),
                      child: Container(
                        width: screenWidth * 0.35,
                        height: screenWidth * 0.35,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Theme.of(
                                context,
                              ).colorScheme.primary.withOpacity(0.3),
                              blurRadius: 25,
                              offset: const Offset(0, 12),
                            ),
                          ],
                        ),
                        child: ModernProfileImage(
                          fadeAnimation: widget.fadeAnimation,
                          size: Size(screenWidth * 0.30, screenWidth * 0.30),
                          fit: BoxFit.cover,
                          isDesktop: true,
                          isTablet: false,
                          images: [AppAssets.hamza22png],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          // Content section
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.08,
              vertical: screenHeight * 0.05,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildGreeting(fontSize: 24),
                const SizedBox(height: 20),
                _buildName(fontSize: 48),
                const SizedBox(height: 20),
                _buildTitle(fontSize: 18),
                const SizedBox(height: 25),
                _buildDescription(),
                const SizedBox(height: 40),
                _buildSocialIcons(),
                const SizedBox(height: 30),
                _buildCTAButtons(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileLayout(
    BuildContext context,
    double screenWidth,
    double screenHeight,
  ) {
    return SizedBox(
      height: screenHeight,
      child: Stack(
        children: [
          // Background with profile image
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: screenHeight * 0.35,
            child: Stack(
              children: [
                // Profile image as background
                Positioned.fill(
                  child: ModernProfileImage(
                    fadeAnimation: widget.fadeAnimation,
                    size: Size(screenWidth, screenHeight * 0.65),
                    fit: BoxFit.cover,
                    isDesktop: false,
                    isTablet: false,
                    images: [AppAssets.hamza22png],
                  ),
                ),
                // Modern gradient overlay
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.2),
                          Colors.black.withOpacity(0.4),
                          Colors.black.withOpacity(0.8),
                        ],
                        stops: [0.0, 0.5, 1.0],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Text overlay with better positioning
          Positioned(
            bottom: screenHeight * 0.38,
            left: 24,
            right: 24,
            child: FadeTransition(
              opacity: widget.fadeAnimation,
              child: SlideTransition(
                position: widget.slideAnimation,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildGreeting(fontSize: 18, color: Colors.white),
                    const SizedBox(height: 8),
                    _buildName(fontSize: 36, color: Colors.white),
                    const SizedBox(height: 8),
                    _buildTitle(
                      fontSize: 16,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Bottom section with Material 3 design
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: screenHeight * 0.35,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Handle bar
                    Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Theme.of(
                          context,
                        ).colorScheme.outline.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Short description
                    _buildDescription(isMobile: true),
                    const SizedBox(height: 32),

                    // Social icons
                    _buildSocialIcons(isMobile: true),
                    const SizedBox(height: 24),

                    // CTA Buttons
                    _buildCTAButtons(isMobile: true),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescription({bool isMobile = false}) {
    return SlideTransition(
      position: widget.slideAnimation,
      child: FadeTransition(
        opacity: widget.fadeAnimation,
        child: Text(
          AppTextContent.aboutDescription,
          style: TextStyle(
            fontSize: isMobile ? 14 : 16,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
            height: 1.6,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

  Widget _buildCTAButtons({bool isMobile = false}) {
    return SlideTransition(
      position: _socialSlideAnimation,
      child: FadeTransition(
        opacity: widget.fadeAnimation,
        child: isMobile
            ? Column(
                children: [
                  _buildPrimaryButton("View My Work", true),
                  const SizedBox(height: 12),
                  _buildSecondaryButton("Download CV", false),
                ],
              )
            : Row(
                children: [
                  _buildPrimaryButton("View My Work", false),
                  const SizedBox(width: 16),
                  _buildSecondaryButton("Download CV", false),
                ],
              ),
      ),
    );
  }

  Widget _buildPrimaryButton(String text, bool isFullWidth) {
    return SizedBox(
      width: isFullWidth ? double.infinity : null,
      child: FilledButton.icon(
        onPressed: () {
          _launchURL(AppLinks.github);
        },
        icon: const Icon(Icons.work_outline),
        label: Text(text),
        style: FilledButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  Widget _buildSecondaryButton(String text, bool isFullWidth) {
    return SizedBox(
      width: isFullWidth ? double.infinity : null,
      child: OutlinedButton.icon(
        onPressed: () {
          _openCV();
        },
        icon: const Icon(Icons.download_outlined),
        label: Text(text),
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  Future<void> _openCV() async {
    final Uri uri = Uri.parse(AppLinks.cvUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch ${AppLinks.cvUrl}';
    }
  }

  double _getResponsiveFontSize(
    double screenWidth,
    double desktop,
    double tablet,
    double mobile,
  ) {
    if (screenWidth > 1024) return desktop;
    if (screenWidth > 768) return tablet;
    return mobile;
  }

  Widget _buildGreeting({double fontSize = 24, Color? color}) {
    return SlideTransition(
      position: widget.slideAnimation,
      child: FadeTransition(
        opacity: widget.fadeAnimation,
        child: Text(
          AppTextContent.greeting,
          style: TextStyle(
            fontSize: fontSize,
            color: color ?? Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }

  Widget _buildName({double fontSize = 64, Color? color}) {
    return SlideTransition(
      position: widget.slideAnimation,
      child: FadeTransition(
        opacity: widget.fadeAnimation,
        child: Text(
          AppTextContent.fullName,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w800,
            color: color ?? Theme.of(context).colorScheme.onSurface,
            height: 1.1,
            letterSpacing: -0.5,
          ),
        ),
      ),
    );
  }

  Widget _buildTitle({double fontSize = 18, Color? color}) {
    return SlideTransition(
      position: widget.slideAnimation,
      child: FadeTransition(
        opacity: widget.fadeAnimation,
        child: Text(
          AppTextContent.jobTitle,
          style: TextStyle(
            fontSize: fontSize,
            color: color ?? Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.8,
          ),
        ),
      ),
    );
  }

  Widget _buildSocialIcons({bool isDesktop = false, bool isMobile = false}) {
    return SlideTransition(
      position: _socialSlideAnimation,
      child: FadeTransition(
        opacity: widget.fadeAnimation,
        child: Row(
          mainAxisAlignment: isMobile
              ? MainAxisAlignment.center
              : MainAxisAlignment.start,
          children: [
            _buildSocialIcon(AppAssets.vector, AppLinks.email, 0),
            SizedBox(width: isDesktop ? 24 : 20),
            _buildSocialIcon(AppAssets.linkedin, AppLinks.linkedin, 1),
            SizedBox(width: isDesktop ? 24 : 20),
            _buildSocialIcon(AppAssets.github2, AppLinks.github, 2),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialIcon(String assetPath, String url, int index) {
    return TweenAnimationBuilder(
      duration: Duration(milliseconds: 600 + (index * 200)),
      tween: Tween<double>(begin: 0, end: 1),
      builder: (context, double value, child) {
        return Transform.scale(
          scale: value,
          child: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).colorScheme.shadow.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () => _launchURL(url),
                child: Center(
                  child: Image.asset(
                    assetPath,
                    width: 24,
                    height: 24,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}

