import 'package:flutter/material.dart';
import 'package:hamza_portfolio_app/core/constants/app_colors.dart';
import 'package:hamza_portfolio_app/features/portfolio/data/models/project_model.dart';

class ProjectDetailDialog extends StatefulWidget {
  final ProjectModel project;

  const ProjectDetailDialog({
    Key? key,
    required this.project,
  }) : super(key: key);

  @override
  State<ProjectDetailDialog> createState() => _ProjectDetailDialogState();
}

class _ProjectDetailDialogState extends State<ProjectDetailDialog>
    with TickerProviderStateMixin {
  late AnimationController _slideController;
  late AnimationController _fadeController;
  late AnimationController _scaleController;

  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _backdropAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startAnimations();
  }

  void _initializeAnimations() {
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutBack,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOut,
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _scaleController,
      curve: Curves.elasticOut,
    ));

    _backdropAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOut,
    ));
  }

  void _startAnimations() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) {
        _fadeController.forward();
        _slideController.forward();
      }
    });

    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) {
        _scaleController.forward();
      }
    });
  }

  @override
  void dispose() {
    _slideController.dispose();
    _fadeController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  void _closeDialog() async {
    await Future.wait([
      _scaleController.reverse(),
      _slideController.reverse(),
      _fadeController.reverse(),
    ]);
    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([_fadeController, _slideController, _scaleController]),
      builder: (context, child) {
        return Stack(
          children: [
            // Animated Backdrop
            Positioned.fill(
              child: AnimatedBuilder(
                animation: _backdropAnimation,
                builder: (context, child) {
                  return Container(
                    color: Colors.black.withOpacity(0.8 * _backdropAnimation.value),
                  );
                },
              ),
            ),
            // Dialog Content
            Dialog(
              backgroundColor: Colors.transparent,
              insetPadding: const EdgeInsets.all(20),
              child: SlideTransition(
                position: _slideAnimation,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Transform.scale(
                    scale: _scaleAnimation.value,
                    child: _buildDialogContent(),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDialogContent() {
    return Container(
      constraints: BoxConstraints(
        maxWidth: 900,
        maxHeight: MediaQuery.of(context).size.height * 0.85,
      ),
      decoration: _buildDialogDecoration(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHeader(),
          Flexible(child: _buildBody()),
        ],
      ),
    );
  }

  BoxDecoration _buildDialogDecoration() {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: isDark
            ? [
          AppColors.darkBackground,
          AppColors.darkSurface,
          AppColors.darkBackground,
        ]
            : [
          AppColors.lightBackground,
          AppColors.lightSurface,
          AppColors.lightBackground,
        ],
      ),
      borderRadius: BorderRadius.circular(28),
      border: Border.all(
        color: AppColors.gradientStart.withOpacity(0.3),
        width: 2,
      ),
      boxShadow: [
        BoxShadow(
          color: AppColors.gradientStart.withOpacity(0.3),
          blurRadius: 30,
          offset: const Offset(0, 15),
          spreadRadius: 5,
        ),
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          blurRadius: 20,
          offset: const Offset(0, 10),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.gradientStart.withOpacity(0.1),
            AppColors.gradientEnd.withOpacity(0.05),
          ],
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(28),
          topRight: Radius.circular(28),
        ),
        border: Border(
          bottom: BorderSide(
            color: AppColors.getTextColor(context).withOpacity(0.1),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Subtitle with animated appearance
                AnimatedBuilder(
                  animation: _fadeController,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(0, 20 * (1 - _fadeController.value)),
                      child: Opacity(
                        opacity: _fadeController.value,
                        child: Text(
                          widget.project.subtitle,
                          style: TextStyle(
                            color: AppColors.gradientStart,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 12),
                // Title with delayed animation
                AnimatedBuilder(
                  animation: _scaleController,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(0, 30 * (1 - _scaleController.value)),
                      child: Opacity(
                        opacity: _scaleController.value,
                        child: Text(
                          widget.project.title,
                          style: TextStyle(
                            color: AppColors.getTextColor(context),
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          // Close button with hover animation
          _buildCloseButton(),
        ],
      ),
    );
  }

  Widget _buildCloseButton() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.getTextColor(context).withOpacity(0.1),
        borderRadius: BorderRadius.circular(50),
        border: Border.all(
          color: AppColors.getTextColor(context).withOpacity(0.2),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _closeDialog,
          borderRadius: BorderRadius.circular(50),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Icon(
              Icons.close_rounded,
              color: AppColors.getTextColor(context),
              size: 24,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildProjectImage(),
          const SizedBox(height: 32),
          _buildAnimatedSection(
            title: 'Project Overview',
            delay: 0.2,
            child: _buildDescription(),
          ),
          const SizedBox(height: 32),
          _buildAnimatedSection(
            title: 'Technologies Used',
            delay: 0.4,
            child: _buildTechnologyTags(),
          ),
          // const SizedBox(height: 32),
          // // _buildAnimatedSection(
          // //   title: 'Key Features',
          // //   delay: 0.6,
          //   // child: _buildKeyFeatures(),
          // ),
        ],
      ),
    );
  }

  Widget _buildProjectImage() {
    return AnimatedBuilder(
      animation: _fadeController,
      builder: (context, child) {
        return Transform.scale(
          scale: 0.9 + (0.1 * _fadeController.value),
          child: Opacity(
            opacity: _fadeController.value,
            child: Container(
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: AppColors.logoGradient.scale(0.3),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: AppColors.gradientStart.withOpacity(0.3),
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.gradientStart.withOpacity(0.2),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      widget.project.imageAsset,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.1),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAnimatedSection({
    required String title,
    required double delay,
    required Widget child,
  }) {
    return AnimatedBuilder(
      animation: _fadeController,
      builder: (context, childWidget) {
        final animationValue = (_fadeController.value - delay).clamp(0.0, 1.0);

        return Transform.translate(
          offset: Offset(0, 30 * (1 - animationValue)),
          child: Opacity(
            opacity: animationValue,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: AppColors.getTextColor(context),
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 16),
                child,
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDescription() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.getSurfaceColor(context).withOpacity(0.3),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.getTextColor(context).withOpacity(0.1),
        ),
      ),
      child: Text(
        widget.project.description,
        style: TextStyle(
          color: AppColors.getTextColor(context).withOpacity(0.8),
          fontSize: 16,
          height: 1.8,
          letterSpacing: 0.3,
        ),
      ),
    );
  }

  Widget _buildTechnologyTags() {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: widget.project.tags.asMap().entries.map((entry) {
        final index = entry.key;
        final tag = entry.value;

        return AnimatedBuilder(
          animation: _scaleController,
          builder: (context, child) {
            final tagDelay = index * 0.1;
            final animationValue = (_scaleController.value - tagDelay).clamp(0.0, 1.0);

            return Transform.scale(
              scale: 0.8 + (0.2 * animationValue),
              child: Opacity(
                opacity: animationValue,
                child: _buildEnhancedTechnologyTag(tag),
              ),
            );
          },
        );
      }).toList(),
    );
  }

  Widget _buildEnhancedTechnologyTag(String tag) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.getSkillColor(tag).withOpacity(0.2),
            AppColors.getSkillColor(tag).withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: AppColors.getSkillColor(tag).withOpacity(0.6),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.getSkillColor(tag).withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Text(
        tag,
        style: TextStyle(
          color: AppColors.getSkillColor(tag),
          fontSize: 14,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

}