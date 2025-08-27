import 'package:flutter/material.dart';
import 'package:hamza_portfolio_app/features/portfolio/data/models/project_model.dart';
import 'package:hamza_portfolio_app/features/portfolio/presentation/widgets/project/project_card.dart';


class ProjectsGrid extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = _getCrossAxisCount(constraints.maxWidth);
        final childAspectRatio = _getChildAspectRatio(constraints.maxWidth);

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 30,
            mainAxisSpacing: 40,
            childAspectRatio: childAspectRatio,
          ),
          itemCount: projects.length,
          itemBuilder: (context, index) => _buildAnimatedProjectCard(
            context,
            index,
            crossAxisCount,
          ),
        );
      },
    );
  }

  Widget _buildAnimatedProjectCard(
      BuildContext context,
      int index,
      int crossAxisCount,
      ) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) {
        return FadeTransition(
          opacity: _createFadeAnimation(index),
          child: SlideTransition(
            position: _createSlideAnimation(index),
            child: ProjectCard(
              project: projects[index],
              isLarge: crossAxisCount == 1,
              onTap: onProjectTap,
            ),
          ),
        );
      },
    );
  }

  Animation<double> _createFadeAnimation(int index) {
    return Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Interval(
          0.3 + (index * 0.1),
          1.0,
          curve: Curves.easeOut,
        ),
      ),
    );
  }

  Animation<Offset> _createSlideAnimation(int index) {
    return Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Interval(
          0.3 + (index * 0.1),
          1.0,
          curve: Curves.easeOutCubic,
        ),
      ),
    );
  }

  int _getCrossAxisCount(double width) {
    if (width > 1200) return 2;
    if (width > 800) return 2;
    return 1;
  }

  double _getChildAspectRatio(double width) {
    if (width > 1200) return 1.4;
    if (width > 800) return 1.2;
    return 0.8;
  }
}
