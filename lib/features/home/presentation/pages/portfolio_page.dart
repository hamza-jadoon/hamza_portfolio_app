// lib/core/views/main_portfolio_page.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hamza_portfolio_app/core/constants/app_colors.dart';
import 'package:hamza_portfolio_app/core/constants/app_constants.dart';
import 'package:hamza_portfolio_app/core/utils/responsive_helper.dart';
import 'package:hamza_portfolio_app/features/home/presentation/pages/home_page.dart';
import 'package:hamza_portfolio_app/features/portfolio/presentation/module/portfolio_module.dart';
import 'package:hamza_portfolio_app/features/portfolio/presentation/pages/sections/about_section.dart';
import 'package:hamza_portfolio_app/features/portfolio/presentation/pages/sections/skills_section..dart';
import 'package:hamza_portfolio_app/features/portfolio/presentation/widgets/navigation/portfolio_navigation_bar.dart';


class MainPortfolioPage extends StatefulWidget {
  const MainPortfolioPage({Key? key}) : super(key: key);

  @override
  State<MainPortfolioPage> createState() => _MainPortfolioPageState();
}

class _MainPortfolioPageState extends State<MainPortfolioPage>
    with TickerProviderStateMixin {

  // Animation Controllers
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  // Navigation Controllers
  late ScrollController _scrollController;

  // State Variables
  int _currentSection = 0;
  bool _isScrolled = false;
  bool _isDisposed = false;

  // Global Keys for each section
  final GlobalKey _homeKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _portfolioKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _initializeControllers();
    _setupAnimations();
    _setupScrollListener();
    _startInitialAnimations();
  }

  void _initializeControllers() {
    _fadeController = AnimationController(
      duration: AppConstants.fadeAnimationDuration,
      vsync: this,
    );

    _slideController = AnimationController(
      duration: AppConstants.slideAnimationDuration,
      vsync: this,
    );

    _scrollController = ScrollController();
  }

  void _setupAnimations() {
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(-0.5, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));
  }

  void _setupScrollListener() {
    _scrollController.addListener(() {
      if (!_isDisposed && mounted) { // Added mounted check
        setState(() {
          _isScrolled = _scrollController.offset > 50;
        });
        _updateCurrentSection();
      }
    });
  }

  void _updateCurrentSection() {
    if (!mounted) return; // Safety check

    final scrollOffset = _scrollController.offset;
    final screenHeight = MediaQuery.of(context).size.height;

    int newSection = 0;
    if (scrollOffset < screenHeight * 0.5) {
      newSection = 0;
    } else if (scrollOffset < screenHeight * 1.5) {
      newSection = 1;
    } else if (scrollOffset < screenHeight * 2.5) {
      newSection = 2;
    } else {
      newSection = 3;
    }

    _setCurrentSection(newSection);
  }

  void _setCurrentSection(int section) {
    if (_currentSection != section && mounted) {
      setState(() {
        _currentSection = section;
      });
    }
  }

  void _startInitialAnimations() {
    Future.delayed(const Duration(milliseconds: 300), () {
      if (!_isDisposed && mounted) {
        _fadeController.forward();
        _slideController.forward();
      }
    });
  }

  @override
  void dispose() {
    _isDisposed = true;
    _fadeController.dispose();
    _slideController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _navigateToSection(int section) {
    if (section < 0 || section > 3 || _isDisposed || !mounted) return;

    HapticFeedback.lightImpact();

    final screenHeight = MediaQuery.of(context).size.height;
    double targetOffset;

    switch (section) {
      case 0:
        targetOffset = 0;
        break;
      case 1:
        targetOffset = screenHeight;
        break;
      case 2:
        targetOffset = screenHeight * 2;
        break;
      case 3:
        targetOffset = screenHeight * 3;
        break;
      default:
        targetOffset = 0;
    }

    _scrollController.animateTo(
      targetOffset,
      duration: AppConstants.pageTransitionDuration,
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: [
          _buildScrollView(),
          _buildNavigationBar(),
        ],
      ),
    );
  }

  Widget _buildScrollView() {
    return SingleChildScrollView(
      controller: _scrollController,
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          // Home Section
          SizedBox(
            key: _homeKey,
            height: MediaQuery.of(context).size.height,
            child: HomePage(
              fadeAnimation: _fadeAnimation,
              slideAnimation: _slideAnimation,
            ),
          ),

          // About Section
          SizedBox(
            key: _aboutKey,
            height: MediaQuery.of(context).size.height,
            child: const AboutPage(),
          ),

          // Skills Section
          SizedBox(
            key: _skillsKey,
            height: MediaQuery.of(context).size.height,
            child: const SkillsPage(),
          ),

          // Portfolio Section - FIXED: Using PortfolioModule instead of PortfolioSection
          SizedBox(
            key: _portfolioKey,
            height: MediaQuery.of(context).size.height,
            child: const PortfolioModule(), // ✅ This includes all providers
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationBar() {
    return PortfolioNavigationBar(
      currentPageIndex: _currentSection,
      hasScrolled: _isScrolled,
      onPageChanged: _navigateToSection,
      isDesktopLayout: ResponsiveHelper.isDesktop(context),
    );
  }
}