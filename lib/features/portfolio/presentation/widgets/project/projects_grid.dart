import 'package:flutter/material.dart';
import 'package:hamza_portfolio_app/features/portfolio/data/models/project_model.dart';
import 'package:hamza_portfolio_app/features/portfolio/presentation/widgets/project/project_card.dart';

class ProjectsGrid extends StatefulWidget {
  final List<ProjectModel> projects;
  final AnimationController animationController;
  final VoidCallback? onProjectTap;

  const ProjectsGrid({
    Key? key,
    required this.projects,
    required this.animationController,
    this.onProjectTap,
  }) : super(key: key);

  @override
  State<ProjectsGrid> createState() => _ProjectsGridState();
}

class _ProjectsGridState extends State<ProjectsGrid>
    with TickerProviderStateMixin {
  late AnimationController _containerController;
  late Animation<double> _containerAnimation;

  @override
  void initState() {
    super.initState();
    _initializeContainerAnimation();
  }

  void _initializeContainerAnimation() {
    _containerController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _containerAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _containerController,
      curve: Curves.easeOutQuart,
    ));

    // Start container animation
    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) {
        _containerController.forward();
      }
    });
  }

  @override
  void dispose() {
    _containerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _containerAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: 0.8 + (_containerAnimation.value * 0.2),
          child: Opacity(
            opacity: _containerAnimation.value,
            child: LayoutBuilder(
              builder: (context, constraints) {
                final crossAxisCount = _getCrossAxisCount(constraints.maxWidth);
                final childAspectRatio = _getChildAspectRatio(constraints.maxWidth);
                final spacing = _getSpacing(constraints.maxWidth);

                return Container(
                  padding: EdgeInsets.all(spacing / 2),
                  child: _buildStaggeredGrid(
                    crossAxisCount: crossAxisCount,
                    childAspectRatio: childAspectRatio,
                    spacing: spacing,
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildStaggeredGrid({
    required int crossAxisCount,
    required double childAspectRatio,
    required double spacing,
  }) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: spacing,
        mainAxisSpacing: spacing,
        childAspectRatio: childAspectRatio,
      ),
      itemCount: widget.projects.length,
      itemBuilder: (context, index) => _buildAnimatedProjectCard(
        context,
        index,
        crossAxisCount,
      ),
    );
  }

  Widget _buildAnimatedProjectCard(
      BuildContext context,
      int index,
      int crossAxisCount,
      ) {
    // Calculate delay based on position for staggered animation
    final row = index ~/ crossAxisCount;
    final col = index % crossAxisCount;
    final delay = (row * 0.1) + (col * 0.05);

    return AnimatedBuilder(
      animation: widget.animationController,
      builder: (context, child) {
        return FadeTransition(
          opacity: _createFadeAnimation(delay),
          child: SlideTransition(
            position: _createSlideAnimation(delay),
            child: Transform.scale(
              scale: _createScaleAnimation(delay).value,
              child: _buildCardWithHeroAnimation(index, crossAxisCount),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCardWithHeroAnimation(int index, int crossAxisCount) {
    return Hero(
      tag: 'project_${widget.projects[index].title}',
      child: Material(
        color: Colors.transparent,
        child: ProjectCard(
          project: widget.projects[index],
          isLarge: crossAxisCount <= 2,
          onTap: widget.onProjectTap,
        ),
      ),
    );
  }

  Animation<double> _createFadeAnimation(double delay) {
    final startInterval = (0.1 + delay).clamp(0.0, 0.8);
    final endInterval = (startInterval + 0.3).clamp(0.1, 1.0);

    return Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: widget.animationController,
        curve: Interval(
          startInterval,
          endInterval,
          curve: Curves.easeOutQuart,
        ),
      ),
    );
  }

  Animation<Offset> _createSlideAnimation(double delay) {
    final startInterval = (0.1 + delay).clamp(0.0, 0.8);
    final endInterval = (startInterval + 0.4).clamp(0.1, 1.0);

    return Tween<Offset>(
      begin: const Offset(0, 0.8),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: widget.animationController,
        curve: Interval(
          startInterval,
          endInterval,
          curve: Curves.easeOutBack,
        ),
      ),
    );
  }

  Animation<double> _createScaleAnimation(double delay) {
    final startInterval = (0.15 + delay).clamp(0.0, 0.8);
    final endInterval = (startInterval + 0.3).clamp(0.1, 1.0);

    return Tween<double>(
      begin: 0.7,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: widget.animationController,
        curve: Interval(
          startInterval,
          endInterval,
          curve: Curves.elasticOut,
        ),
      ),
    );
  }

  int _getCrossAxisCount(double width) {
    if (width > 1600) return 4;  // Extra large screens
    if (width > 1200) return 3;  // Large desktop
    if (width > 800) return 2;   // Desktop/Tablet landscape
    if (width > 500) return 2;   // Large mobile/Small tablet
    return 1;                    // Mobile portrait
  }

  double _getChildAspectRatio(double width) {
    if (width > 1600) return 0.75; // 4 columns - taller cards
    if (width > 1200) return 0.85; // 3 columns
    if (width > 800) return 0.9;   // 2 columns
    if (width > 500) return 1.0;   // 2 columns on mobile
    return 1.1;                    // 1 column - slightly wider
  }

  double _getSpacing(double width) {
    if (width > 1200) return 32.0; // Large screens - more spacing
    if (width > 800) return 24.0;  // Medium screens
    if (width > 500) return 20.0;  // Small screens
    return 16.0;                   // Mobile - compact spacing
  }
}