import 'package:flutter/material.dart';
import 'package:hamza_portfolio_app/core/constants/app_texts.dart';
import 'package:hamza_portfolio_app/core/utils/responsive_helper.dart';
import 'package:hamza_portfolio_app/features/portfolio/data/models/services_model.dart';
import 'package:hamza_portfolio_app/features/portfolio/presentation/widgets/service/service_card.dart';
import 'package:hamza_portfolio_app/features/shared/widgets/modern_background.dart';
import 'header_section.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late AnimationController _floatController;

  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _floatAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startAnimations();
  }

  void _initializeAnimations() {
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 900),
      vsync: this,
    );

    _floatController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOut,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));

    _floatAnimation = Tween<double>(
      begin: -8,
      end: 8,
    ).animate(CurvedAnimation(
      parent: _floatController,
      curve: Curves.easeInOut,
    ));
  }

  void _startAnimations() {
    _fadeController.forward();
    _slideController.forward();
    _floatController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    _floatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDesktop = ResponsiveHelper.isDesktop(context);
    final isTablet = ResponsiveHelper.isTablet(context);
    final screenSize = MediaQuery.of(context).size;

    return Stack(
      children: [
        Positioned.fill(
          child: AnimatedBuilder(
            animation: _floatAnimation,
            builder: (context, child) {
              return CustomPaint(
                painter: ModernBackgroundPainter(
                  primaryColor: colorScheme.primary,
                  secondaryColor: colorScheme.secondary,
                  tertiaryColor: colorScheme.tertiary,
                  surfaceColor: colorScheme.surface,
                  screenWidth: screenSize.width,
                  screenHeight: screenSize.height,
                  animationValue: _floatAnimation.value,
                  isDesktop: isDesktop,
                  isTablet: isTablet,
                ),
                child: Container(),
              );
            },
          ),
        ),

        // Main content
        SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: isDesktop ? 60 : 24,
              vertical: 120,
            ),
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: Column(
                  children: [
                    const SectionHeader(title: AppTextContent.navAboutMe),
                    const SizedBox(height: 60),
                    _buildDescription(context),
                    const SizedBox(height: 80),
                    const SectionHeader(title: AppTextContent.explore),
                    const SizedBox(height: 60),
                    _buildServicesSection(context),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDescription(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      constraints: const BoxConstraints(maxWidth: 700),
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: (colorScheme.surfaceContainer)
            .withOpacity(0.5),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: colorScheme.outline.withOpacity(0.1),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 60,
            height: 4,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  colorScheme.primary,
                  colorScheme.secondary,
                ],
              ),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 24),

          Text(
            AppTextContent.aboutDescription,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 17,
              color: colorScheme.onSurface.withOpacity(0.8),
              height: 1.7,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServicesSection(BuildContext context) {
    final services = _getServices();
    final isDesktop = ResponsiveHelper.isDesktop(context);

    return Column(
      children: [
        isDesktop
            ? Row(
          children: [
            Expanded(
              child: _buildServiceWithDelay(services[0], 0),
            ),
            const SizedBox(width: 40),
            Expanded(
              child: _buildServiceWithDelay(services[1], 200),
            ),
          ],
        )
            : Column(
          children: [
            _buildServiceWithDelay(services[0], 0),
            const SizedBox(height: 32),
            _buildServiceWithDelay(services[1], 200),
          ],
        ),
        SizedBox(height: isDesktop ? 40 : 32),

        // Services Row 2
        Container(
          constraints: BoxConstraints(
            maxWidth: isDesktop ? 500 : double.infinity,
          ),
          child: _buildServiceWithDelay(services[2], 400),
        ),
      ],
    );
  }

  Widget _buildServiceWithDelay(ServiceModel service, int delay) {
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 600 + delay),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, (1 - value) * 30),
          child: Opacity(
            opacity: value,
            child: ServiceCard(service: service),
          ),
        );
      },
    );
  }

  List<ServiceModel> _getServices() {
    return [
      ServiceModel(
        title: AppTextContent.development,
        description: AppTextContent.appdevelopdic,
        icon: Icons.code_rounded,
      ),
      ServiceModel(
        title: AppTextContent.design,
        description: AppTextContent.uiuxdic,
        icon: Icons.palette_rounded,
      ),
      ServiceModel(
        title: AppTextContent.maintenance,
        description: AppTextContent.maintenancedic,
        icon: Icons.build_rounded,
      ),
    ];
  }
}
