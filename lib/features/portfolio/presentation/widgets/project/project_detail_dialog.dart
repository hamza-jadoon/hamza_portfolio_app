import 'package:flutter/material.dart';
import 'package:hamza_portfolio_app/core/constants/app_colors.dart';
import 'package:hamza_portfolio_app/features/portfolio/data/models/project_model.dart';

class ProjectDetailDialog extends StatelessWidget {
  final ProjectModel project;

  const ProjectDetailDialog({
    Key? key,
    required this.project,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: 800,
          maxHeight: MediaQuery.of(context).size.height * 0.8,
        ),
        decoration: _buildDialogDecoration(context),
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(child: _buildBody(context)),
          ],
        ),
      ),
    );
  }

  BoxDecoration _buildDialogDecoration(BuildContext context) {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: Theme.of(context).brightness == Brightness.dark
            ? [AppColors.darkBackground, AppColors.darkSurface]
            : [AppColors.lightBackground, AppColors.lightSurface],
      ),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(
        color: AppColors.getTextColor(context).withOpacity(0.2),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  project.subtitle,
                  style: TextStyle(
                    color: AppColors.gradientStart,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  project.title,
                  style: TextStyle(
                    color: AppColors.getTextColor(context),
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(
              Icons.close,
              color: AppColors.getTextColor(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildProjectImage(),
          const SizedBox(height: 30),
          _buildSectionTitle(context, 'Project Description'),
          const SizedBox(height: 12),
          _buildDescription(context),
          const SizedBox(height: 30),
          _buildSectionTitle(context, 'Technologies'),
          const SizedBox(height: 12),
          _buildTechnologyTags(),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildProjectImage() {
    return Builder(
      builder: (context) {
        return Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: AppColors.logoGradient.scale(0.3),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppColors.getTextColor(context).withOpacity(0.1),
            ),
          ),
          child: const Center(
            child: Icon(
              Icons.flutter_dash,
              size: 48,
              color: Colors.white,
            ),
          ),
        );
      }
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: TextStyle(
        color: AppColors.getTextColor(context),
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildDescription(BuildContext context) {
    return Text(
      project.description,
      style: TextStyle(
        color: AppColors.getTextColor(context).withOpacity(0.8),
        fontSize: 14,
        height: 1.6,
      ),
    );
  }

  Widget _buildTechnologyTags() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: project.tags
          .map((tag) => _buildTechnologyTag(tag))
          .toList(),
    );
  }

  Widget _buildTechnologyTag(String tag) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
