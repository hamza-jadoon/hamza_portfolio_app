import 'package:flutter/material.dart';
import 'package:hamza_portfolio_app/core/constants/app_constants.dart';
import 'package:hamza_portfolio_app/core/utils/responsive_helper.dart';
import 'package:hamza_portfolio_app/features/portfolio/data/models/portfolio_view_model.dart';
import 'package:hamza_portfolio_app/features/portfolio/presentation/widgets/project/projects_grid.dart';
import 'package:hamza_portfolio_app/features/shared/widgets/loading_widget.dart';
import 'package:hamza_portfolio_app/features/shared/widgets/portfolio_header.dart';
import 'package:provider/provider.dart';
import 'package:hamza_portfolio_app/core/constants/app_colors.dart';


class PortfolioSection extends StatefulWidget {
  const PortfolioSection({Key? key}) : super(key: key);

  @override
  State<PortfolioSection> createState() => _PortfolioSectionState();
}

class _PortfolioSectionState extends State<PortfolioSection>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _loadPortfolioData();
  }

  void _initializeAnimations() {
    _animationController = AnimationController(
      duration: AppConstants.animationDuration,
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOutCubic,
      ),
    );

    _animationController.forward();
  }

  void _loadPortfolioData() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PortfolioViewModel>().loadProjects();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: _buildBackgroundDecoration(context),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: ResponsiveHelper.getHorizontalPadding(context),
          vertical: 80,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              PortfolioHeader(
                fadeAnimation: _fadeAnimation,
                slideAnimation: _slideAnimation,
              ),
              const SizedBox(height: 80),
              _buildContent(),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildBackgroundDecoration(BuildContext context) {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: Theme.of(context).brightness == Brightness.dark
            ? [
          AppColors.darkBackground,
          AppColors.darkSurface,
          AppColors.darkPrimary.withOpacity(0.3),
        ]
            : [
          AppColors.lightBackground,
          AppColors.lightSurface,
          AppColors.lightPrimary.withOpacity(0.1),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return Consumer<PortfolioViewModel>(
      builder: (context, viewModel, child) {
        if (viewModel.isLoading) {
          return const LoadingWidget();
        }

        if (viewModel.hasError) {
          return ErrorWidget(viewModel.errorMessage ?? 'An error occurred');
        }


        if (!viewModel.hasProjects) {
          return const Center(
            child: Text('No projects available'),
          );
        }

        return ProjectsGrid(
          projects: viewModel.projects,
          animationController: _animationController,
          onProjectTap: () {
            // Handle project tap if needed
          },
        );
      },
    );
  }
}