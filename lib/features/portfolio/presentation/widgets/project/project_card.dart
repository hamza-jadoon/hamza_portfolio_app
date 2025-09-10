import 'package:flutter/material.dart';
import 'package:hamza_portfolio_app/core/constants/app_colors.dart';
import 'package:hamza_portfolio_app/features/portfolio/data/models/project_model.dart';
import 'package:hamza_portfolio_app/features/portfolio/presentation/widgets/project/project_detail_dialog.dart';

class ProjectCard extends StatefulWidget {
  final ProjectModel project;
  final bool isLarge;
  final VoidCallback? onTap;

  const ProjectCard({
    Key? key,
    required this.project,
    required this.isLarge,
    this.onTap,
  }) : super(key: key);

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _hoverController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _elevationAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    _hoverController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.05,
    ).animate(CurvedAnimation(
      parent: _hoverController,
      curve: Curves.easeOut,
    ));

    _elevationAnimation = Tween<double>(
      begin: 8.0,
      end: 20.0,
    ).animate(CurvedAnimation(
      parent: _hoverController,
      curve: Curves.easeOut,
    ));
  }

  @override
  void dispose() {
    _hoverController.dispose();
    super.dispose();
  }

  void _handleHoverEnter() {
    if (mounted) {
      setState(() => _isHovered = true);
      _hoverController.forward();
    }
  }

  void _handleHoverExit() {
    if (mounted) {
      setState(() => _isHovered = false);
      _hoverController.reverse();
    }
  }

  void _handleTap() {
    widget.onTap?.call();
    _openProjectDetails();
  }

  void _openProjectDetails() {
    showDialog(
      context: context,
      builder: (context) => ProjectDetailDialog(project: widget.project),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _handleHoverEnter(),
      onExit: (_) => _handleHoverExit(),
      child: GestureDetector(
        onTap: _handleTap,
        child: AnimatedBuilder(
          animation: _hoverController,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: Container(
                decoration: _buildCardDecoration(context),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Column(
                    children: [
                      // Project Image - Takes most of the space
                      Expanded(
                        flex: 3,
                        child: _buildProjectImage(),
                      ),
                      // Project Name - Bottom section
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? AppColors.darkSurface.withOpacity(0.9)
                              : AppColors.lightSurface.withOpacity(0.9),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              widget.project.title,
                              style: TextStyle(
                                color: AppColors.getTextColor(context),
                                fontSize: widget.isLarge ? 18 : 16,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            if (widget.project.subtitle.isNotEmpty) ...[
                              const SizedBox(height: 4),
                              Text(
                                widget.project.subtitle,
                                style: TextStyle(
                                  color: AppColors.gradientStart,
                                  fontSize: widget.isLarge ? 12 : 11,
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  BoxDecoration _buildCardDecoration(BuildContext context) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: Theme.of(context).brightness == Brightness.dark
            ? [
          AppColors.darkSurface.withOpacity(0.8),
          AppColors.darkSurface.withOpacity(0.6),
        ]
            : [
          AppColors.lightSurface.withOpacity(0.9),
          AppColors.lightSurface.withOpacity(0.7),
        ],
      ),
      border: Border.all(
        color: _isHovered
            ? AppColors.gradientStart.withOpacity(0.5)
            : AppColors.getTextColor(context).withOpacity(0.1),
        width: 1,
      ),
      boxShadow: [
        BoxShadow(
          color: _isHovered
              ? AppColors.gradientStart.withOpacity(0.3)
              : AppColors.getShadowColor(context),
          blurRadius: _elevationAnimation.value,
          offset: Offset(0, _elevationAnimation.value / 2),
        ),
      ],
    );
  }

  Widget _buildProjectImage() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.getSurfaceColor(context).withOpacity(0.5),
        gradient: AppColors.logoGradient.scale(0.3),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Project Image
          Image.asset(
            widget.project.imageAsset,
            fit: BoxFit.cover,
          ),
          // Hover Overlay
          if (_isHovered)
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    AppColors.gradientStart.withOpacity(0.1),
                  ],
                ),
              ),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'View Details',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: widget.isLarge ? 14 : 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}