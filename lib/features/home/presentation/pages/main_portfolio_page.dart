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
  late AnimationController _scrollToTopController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scrollToTopAnimation;

  // Navigation Controllers
  late ScrollController _scrollController;

  // State Variables
  int _currentSection = 0;
  bool _isScrolled = false;
  bool _isDisposed = false;
  bool _showScrollToTop = false;

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

    _scrollToTopController = AnimationController(
      duration: const Duration(milliseconds: 300),
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

    _scrollToTopAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _scrollToTopController,
      curve: Curves.easeInOut,
    ));
  }

  void _setupScrollListener() {
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    // Add safety checks to prevent operations on disposed controllers
    if (_isDisposed || !mounted) return;

    try {
      final scrollOffset = _scrollController.offset;
      final maxScrollExtent = _scrollController.position.maxScrollExtent;

      // Use a post-frame callback to ensure UI updates happen at the right time
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_isDisposed || !mounted) return;

        setState(() {
          _isScrolled = scrollOffset > 50;

          bool shouldShow = scrollOffset > 200 ||
              (maxScrollExtent > 0 && scrollOffset > maxScrollExtent * 0.3);

          if (_showScrollToTop != shouldShow) {
            _showScrollToTop = shouldShow;
            if (_showScrollToTop && !_scrollToTopController.isCompleted) {
              _scrollToTopController.forward();
            } else if (!_showScrollToTop && !_scrollToTopController.isDismissed) {
              _scrollToTopController.reverse();
            }
          }
        });
        _updateCurrentSection();
      });
    } catch (e) {
      // Handle any potential errors during scroll handling
      debugPrint('Error in scroll listener: $e');
    }
  }

  void _updateCurrentSection() {
    if (_isDisposed || !mounted) return;

    try {
      final RenderBox? homeBox = _homeKey.currentContext?.findRenderObject() as RenderBox?;
      final RenderBox? aboutBox = _aboutKey.currentContext?.findRenderObject() as RenderBox?;
      final RenderBox? skillsBox = _skillsKey.currentContext?.findRenderObject() as RenderBox?;
      final RenderBox? portfolioBox = _portfolioKey.currentContext?.findRenderObject() as RenderBox?;

      if (homeBox == null || aboutBox == null || skillsBox == null || portfolioBox == null) return;

      final scrollOffset = _scrollController.offset;

      // Get positions of each section
      final double aboutPosition = aboutBox.localToGlobal(Offset.zero).dy + scrollOffset;
      final skillsPosition = skillsBox.localToGlobal(Offset.zero).dy + scrollOffset;
      final portfolioPosition = portfolioBox.localToGlobal(Offset.zero).dy + scrollOffset;

      int newSection = 0;
      final currentScrollWithOffset = scrollOffset + (MediaQuery.of(context).size.height * 0.3);

      if (currentScrollWithOffset >= portfolioPosition) {
        newSection = 3;
      } else if (currentScrollWithOffset >= skillsPosition) {
        newSection = 2;
      } else if (currentScrollWithOffset >= aboutPosition) {
        newSection = 1;
      } else {
        newSection = 0;
      }

      _setCurrentSection(newSection);
    } catch (e) {
      debugPrint('Error in _updateCurrentSection: $e');
    }
  }

  void _setCurrentSection(int section) {
    if (_currentSection != section && mounted && !_isDisposed) {
      setState(() {
        _currentSection = section;
      });
    }
  }

  void _startInitialAnimations() {
    // Use a post-frame callback instead of Future.delayed for better timing
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_isDisposed || !mounted) return;

      Future.delayed(const Duration(milliseconds: 300), () {
        if (_isDisposed || !mounted) return;

        try {
          _fadeController.forward();
          _slideController.forward();
        } catch (e) {
          debugPrint('Error starting animations: $e');
        }
      });
    });
  }

  void _scrollToTop() {
    if (_isDisposed || !mounted) return;

    HapticFeedback.mediumImpact();

    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  void dispose() {
    // Set disposed flag first to prevent any ongoing operations
    _isDisposed = true;

    // Remove scroll listener first
    _scrollController.removeListener(_onScroll);

    // Stop all animations before disposing controllers
    try {
      _fadeController.stop();
      _slideController.stop();
      _scrollToTopController.stop();
    } catch (e) {
      debugPrint('Error stopping animations: $e');
    }

    // Dispose controllers
    _fadeController.dispose();
    _slideController.dispose();
    _scrollToTopController.dispose();
    _scrollController.dispose();

    super.dispose();
  }

  void _navigateToSection(int section) {
    if (section < 0 || section > 3 || _isDisposed || !mounted) return;

    HapticFeedback.lightImpact();

    // Wait for next frame to ensure widgets are built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_isDisposed || !mounted) return;

      GlobalKey targetKey;
      switch (section) {
        case 0:
          targetKey = _homeKey;
          break;
        case 1:
          targetKey = _aboutKey;
          break;
        case 2:
          targetKey = _skillsKey;
          break;
        case 3:
          targetKey = _portfolioKey;
          break;
        default:
          targetKey = _homeKey;
      }

      final RenderBox? renderBox = targetKey.currentContext?.findRenderObject() as RenderBox?;
      if (renderBox != null) {
        final position = renderBox.localToGlobal(Offset.zero);
        final targetOffset = _scrollController.offset + position.dy;

        _scrollController.animateTo(
          targetOffset,
          duration: AppConstants.pageTransitionDuration,
          curve: Curves.easeInOut,
        );
      }
    });
  }

  double _getSectionHeight(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final isDesktop = ResponsiveHelper.isDesktop(context);

    // Adjust heights based on screen size and device type
    if (isDesktop) {
      return screenHeight;
    } else {
      // On mobile, sections can be flexible height
      return screenHeight;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Add safety check for disposed state
    if (_isDisposed) {
      return const SizedBox.shrink();
    }

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: [
          _buildScrollView(),
          _buildNavigationBar(),
          _buildScrollToTopButton(),
        ],
      ),
    );
  }

  Widget _buildScrollView() {
    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        // Home Section
        SliverToBoxAdapter(
          child: SizedBox(
            key: _homeKey,
            height: _getSectionHeight(context),
            child: HomePage(
              fadeAnimation: _fadeAnimation,
              slideAnimation: _slideAnimation,
            ),
          ),
        ),

        // About Section
        SliverToBoxAdapter(
          child: Container(
            key: _aboutKey,
            constraints: BoxConstraints(
              minHeight: _getSectionHeight(context),
            ),
            child: const AboutPage(),
          ),
        ),

        // Skills Section
        SliverToBoxAdapter(
          child: Container(
            key: _skillsKey,
            constraints: BoxConstraints(
              minHeight: _getSectionHeight(context),
            ),
            child: const SkillsPage(),
          ),
        ),

        // Portfolio Section
        SliverToBoxAdapter(
          child: Container(
            key: _portfolioKey,
            constraints: BoxConstraints(
              minHeight: _getSectionHeight(context),
            ),
            child: const PortfolioModule(),
          ),
        ),
      ],
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

  Widget _buildScrollToTopButton() {
    return Positioned(
      right: ResponsiveHelper.isDesktop(context) ? 30 : 20,
      bottom: ResponsiveHelper.isDesktop(context) ? 30 : 80,
      child: AnimatedBuilder(
        animation: _scrollToTopAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scrollToTopAnimation.value,
            child: Opacity(
              opacity: _scrollToTopAnimation.value,
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(28),
                    onTap: _scrollToTop,
                    child: Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [
                            AppColors.primaryColor,
                            AppColors.primaryColor.withOpacity(0.8),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: const Icon(
                        Icons.keyboard_arrow_up,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}