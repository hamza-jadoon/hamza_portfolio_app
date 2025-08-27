import 'package:flutter/material.dart';
import 'package:hamza_portfolio_app/core/constants/app_colors.dart';
import 'package:hamza_portfolio_app/features/portfolio/data/models/project_model.dart';
import 'package:hamza_portfolio_app/features/portfolio/presentation/widgets/project/project_detail_dialog.dart';
import 'package:hamza_portfolio_app/features/shared/widgets/wireframe_painter.dart';


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
                  child: Container(
                    padding: EdgeInsets.all(widget.isLarge ? 40 : 30),
                    child: widget.isLarge
                        ? _buildLargeLayout()
                        : _buildCompactLayout(),
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

  Widget _buildLargeLayout() {
    return Row(
      children: [
        Expanded(flex: 1, child: _buildContent()),
        const SizedBox(width: 40),
        Expanded(flex: 1, child: _buildMockup()),
      ],
    );
  }

  Widget _buildCompactLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 2, child: _buildMockup()),
        const SizedBox(height: 20),
        Expanded(flex: 3, child: _buildContent()),
      ],
    );
  }

  Widget _buildContent() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildSubtitle(),
          const SizedBox(height: 8),
          _buildTitle(),
          const SizedBox(height: 16),
          _buildDescription(),
          const SizedBox(height: 20),
          _buildTags(),
        ],
      ),
    );
  }

  Widget _buildSubtitle() {
    return Text(
      widget.project.subtitle,
      style: TextStyle(
        color: AppColors.gradientStart,
        fontSize: widget.isLarge ? 14 : 12,
        fontWeight: FontWeight.w500,
        letterSpacing: 1,
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      widget.project.title,
      style: TextStyle(
        color: AppColors.getTextColor(context),
        fontSize: widget.isLarge ? 28 : 20,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildDescription() {
    return Text(
      widget.project.description,
      style: TextStyle(
        color: AppColors.getTextColor(context).withOpacity(0.7),
        fontSize: widget.isLarge ? 14 : 12,
        height: 1.6,
      ),
      maxLines: widget.isLarge ? 6 : 4,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildTags() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: widget.project.tags
          .map((tag) => _buildTag(tag))
          .toList(),
    );
  }

  Widget _buildTag(String tag) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.getSkillColor(tag).withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.getSkillColor(tag).withOpacity(0.5),
        ),
      ),
      child: Text(
        tag,
        style: TextStyle(
          color: AppColors.getSkillColor(tag),
          fontSize: 10,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildMockup() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.getSurfaceColor(context).withOpacity(0.5),
        border: Border.all(
          color: AppColors.getTextColor(context).withOpacity(0.1),
        ),
        gradient: AppColors.logoGradient.scale(0.3),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          children: [
            _buildGradientBackground(),
            _buildWireframeOverlay(),
          ],
        ),
      ),
    );
  }

  Widget _buildGradientBackground() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.gradientStart.withOpacity(0.1),
            AppColors.gradientEnd.withOpacity(0.05),
          ],
        ),
      ),
    );
  }

  Widget _buildWireframeOverlay() {
    return Positioned.fill(
      child: CustomPaint(
        painter: WireframePainter(
          color: AppColors.getTextColor(context).withOpacity(0.3),
        ),
      ),
    );
  }
}