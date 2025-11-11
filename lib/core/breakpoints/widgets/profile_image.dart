// modern_profile_image.dart
import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:hamza_portfolio_app/core/constants/app_assets.dart';

class ModernProfileImage extends StatefulWidget {
  final Animation<double> fadeAnimation;
  final Size? size;
  final BoxFit fit;
  final bool isDesktop;
  final bool isTablet;
  final List<String> images;

  const ModernProfileImage({
    Key? key,
    required this.fadeAnimation,
    this.size,
    required this.fit,
    this.isDesktop = false,
    this.isTablet = false,
    required this.images,
  }) : super(key: key);

  @override
  State<ModernProfileImage> createState() => _ModernProfileImageState();
}

class _ModernProfileImageState extends State<ModernProfileImage>
    with TickerProviderStateMixin {
  late PageController _pageController;
  late Timer _timer;
  late AnimationController _rotationController;
  late AnimationController _pulseController;
  late AnimationController _shimmerController;
  late AnimationController _floatingController;

  late Animation<double> _rotationAnimation;
  late Animation<double> _pulseAnimation;
  late Animation<double> _shimmerAnimation;
  late Animation<double> _floatingAnimation;

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _setupImageSlider();
  }

  void _initializeAnimations() {
    _pageController = PageController();

    // Rotation animation for decorative elements
    _rotationController = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    );
    _rotationAnimation = Tween<double>(
      begin: 0,
      end: 2 * math.pi,
    ).animate(_rotationController);

    // Pulse animation for glow effect
    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _pulseAnimation = Tween<double>(
      begin: 0.8,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));

    // Shimmer animation for loading effect
    _shimmerController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    _shimmerAnimation = Tween<double>(
      begin: -1.0,
      end: 2.0,
    ).animate(CurvedAnimation(
      parent: _shimmerController,
      curve: Curves.easeInOutSine,
    ));

    // Floating animation
    _floatingController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );
    _floatingAnimation = Tween<double>(
      begin: -10,
      end: 10,
    ).animate(CurvedAnimation(
      parent: _floatingController,
      curve: Curves.easeInOut,
    ));

    // Start animations
    _rotationController.repeat();
    _pulseController.repeat(reverse: true);
    _shimmerController.repeat();
    _floatingController.repeat(reverse: true);
  }

  void _setupImageSlider() {
    if ((widget.isDesktop || widget.isTablet) && widget.images.length > 1) {
      _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
        if (_pageController.hasClients) {
          _currentIndex = (_currentIndex + 1) % widget.images.length;
          _pageController.animateToPage(
            _currentIndex,
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeInOutCubic,
          );
        }
      });
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    _rotationController.dispose();
    _pulseController.dispose();
    _shimmerController.dispose();
    _floatingController.dispose();
    if ((widget.isDesktop || widget.isTablet) && widget.images.length > 1) {
      _timer.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isDesktop) {
      return _buildDesktopVersion();
    } else if (widget.isTablet) {
      return _buildTabletVersion();
    } else {
      return _buildMobileVersion();
    }
  }

  Widget _buildDesktopVersion() {
    final screenWidth = MediaQuery.of(context).size.width;
    final imageSize = widget.size ?? Size(screenWidth * 0.35, screenWidth * 0.35);

    return FadeTransition(
      opacity: widget.fadeAnimation,
      child: SizedBox(
        width: imageSize.width + 100,
        height: imageSize.height + 100,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Outer decorative ring
            AnimatedBuilder(
              animation: _rotationAnimation,
              builder: (context, child) {
                return Transform.rotate(
                  angle: _rotationAnimation.value,
                  child: Container(
                    width: imageSize.width + 80,
                    height: imageSize.height + 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        width: 2,
                        color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                      ),
                    ),
                    child: Stack(
                      children: List.generate(8, (index) {
                        final angle = (2 * math.pi * index) / 8;
                        return Positioned(
                          top: (imageSize.height + 80) / 2 - 6 + (imageSize.height + 80) / 2 * math.sin(angle) * 0.9,
                          left: (imageSize.width + 80) / 2 - 6 + (imageSize.width + 80) / 2 * math.cos(angle) * 0.9,
                          child: Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context).colorScheme.primary,
                              boxShadow: [
                                BoxShadow(
                                  color: Theme.of(context).colorScheme.primary.withOpacity(0.6),
                                  blurRadius: 8,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                );
              },
            ),

            // Pulsing glow effect
            AnimatedBuilder(
              animation: _pulseAnimation,
              builder: (context, child) {
                return Transform.scale(
                  scale: _pulseAnimation.value,
                  child: Container(
                    width: imageSize.width + 40,
                    height: imageSize.height + 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          Theme.of(context).colorScheme.primary.withOpacity(0.2),
                          Theme.of(context).colorScheme.primary.withOpacity(0.05),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),

            // Main image container with slider
            AnimatedBuilder(
              animation: _floatingAnimation,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, _floatingAnimation.value),
                  child: Container(
                    width: imageSize.width,
                    height: imageSize.height,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).colorScheme.primary.withOpacity(0.4),
                          blurRadius: 30,
                          offset: const Offset(0, 15),
                        ),
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 50,
                          offset: const Offset(0, 25),
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: widget.images.length > 1
                          ? _buildImageSlider(imageSize)
                          : _buildSingleImage(imageSize),
                    ),
                  ),
                );
              },
            ),

            // Shimmer overlay
            AnimatedBuilder(
              animation: _shimmerAnimation,
              builder: (context, child) {
                return ClipOval(
                  child: Container(
                    width: imageSize.width,
                    height: imageSize.height,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.transparent,
                          Colors.white.withOpacity(0.1),
                          Colors.transparent,
                        ],
                        stops: [
                          _shimmerAnimation.value - 0.3,
                          _shimmerAnimation.value,
                          _shimmerAnimation.value + 0.3,
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabletVersion() {
    final screenWidth = MediaQuery.of(context).size.width;
    final imageSize = widget.size ?? Size(screenWidth * 0.4, screenWidth * 0.4);

    return FadeTransition(
      opacity: widget.fadeAnimation,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Main image with modern frame
          Container(
            width: imageSize.width + 60,
            height: imageSize.height + 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Theme.of(context).colorScheme.primary.withOpacity(0.3),
                  Theme.of(context).colorScheme.secondary.withOpacity(0.2),
                ],
              ),
            ),
            child: Center(
              child: AnimatedBuilder(
                animation: _floatingAnimation,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(0, _floatingAnimation.value * 0.5),
                    child: Container(
                      width: imageSize.width,
                      height: imageSize.height,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: widget.images.length > 1
                            ? _buildImageSlider(imageSize)
                            : _buildSingleImage(imageSize),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          if (widget.images.length > 1) ...[
            const SizedBox(height: 24),
            _buildIndicators(),
          ],
        ],
      ),
    );
  }

  Widget _buildMobileVersion() {
    final screenWidth = MediaQuery.of(context).size.width;
    final imageSize = widget.size ?? Size(screenWidth * 0.6, screenWidth * 0.6);

    return FadeTransition(
      opacity: widget.fadeAnimation,
      child: Container(
        width: imageSize.width + 40,
        height: imageSize.height + 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).colorScheme.primary.withOpacity(0.2),
              Colors.transparent,
              Theme.of(context).colorScheme.secondary.withOpacity(0.1),
            ],
          ),
        ),
        child: Center(
          child: AnimatedBuilder(
            animation: _pulseAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: 0.95 + (_pulseAnimation.value - 1) * 0.05,
                child: Container(
                  width: imageSize.width,
                  height: imageSize.height,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
                      width: 3,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: _buildSingleImage(imageSize),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildImageSlider(Size imageSize) {
    return PageView.builder(
      controller: _pageController,
      onPageChanged: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
      itemCount: widget.images.length,
      itemBuilder: (context, index) {
        return AnimatedBuilder(
          animation: _pageController,
          builder: (context, child) {
            double value = 1.0;
            if (_pageController.position.haveDimensions) {
              value = _pageController.page! - index;
              value = (1 - (value.abs() * 0.3)).clamp(0.7, 1.0);
            }
            return Transform.scale(
              scale: value,
              child: Image.asset(
                widget.images[index],
                fit: widget.fit,
                width: imageSize.width,
                height: imageSize.height,
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildSingleImage(Size imageSize) {
    return Image.asset(
      widget.images.first,
      fit: widget.fit,
      width: imageSize.width,
      height: imageSize.height,
    );
  }

  Widget _buildIndicators() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(widget.images.length, (index) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: _currentIndex == index ? 30 : 10,
          height: 10,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            gradient: _currentIndex == index
                ? LinearGradient(
              colors: [
                Theme.of(context).colorScheme.primary,
                Theme.of(context).colorScheme.secondary,
              ],
            )
                : null,
            color: _currentIndex != index
                ? Theme.of(context).colorScheme.primary.withOpacity(0.3)
                : null,
          ),
        );
      }),
    );
  }
}

// Usage Example in your existing code:
// ignore: use_key_in_widget_constructors
class ProfileImageUsage extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _ProfileImageUsageState createState() => _ProfileImageUsageState();
}

class _ProfileImageUsageState extends State<ProfileImageUsage>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    ));
    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 1024;
    final isTablet = screenWidth > 768 && screenWidth <= 1024;

    return ModernProfileImage(
      fadeAnimation: _fadeAnimation,
      fit: BoxFit.cover,
      isDesktop: isDesktop,
      isTablet: isTablet,
      images: [
        AppAssets.hamza22png,
        AppAssets.hamza1png,
        AppAssets.hamza3,

        // Add more images for slider effect
        // 'assets/images/hamza2.png',
        // 'assets/images/hamza3.png',
      ],
    );
  }
}