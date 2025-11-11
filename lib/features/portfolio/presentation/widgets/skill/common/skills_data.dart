import 'package:flutter/material.dart';
import 'package:hamza_portfolio_app/core/constants/app_assets.dart';
import 'package:hamza_portfolio_app/core/constants/app_colors.dart';
import 'package:hamza_portfolio_app/core/breakpoints/app_texts.dart';
import 'package:hamza_portfolio_app/features/portfolio/data/models/skill_model.dart';

class SkillsData {
  static List<SkillModel> getCurrentSkills() {
    return [
      SkillModel.withAsset(
        name: AppTextContent.skillFlutter,
        color: AppColors.flutterColor,
        assetPath: AppAssets.flutter,
        category: AppTextContent.categoryFramework,
        proficiency: 5,
      ),
      SkillModel.withAsset(
        name: AppTextContent.skillDart,
        color: AppColors.dartColor,
        assetPath: AppAssets.dart,
        category: AppTextContent.categoryProgramming,
        proficiency: 5,
      ),
      SkillModel.withAsset(
        name: AppTextContent.skillFirebase,
        color: AppColors.firebaseColor,
        assetPath: AppAssets.firebase,
        category: AppTextContent.categoryBackend,
        proficiency: 4,
      ),
      SkillModel.withAsset(
        name: AppTextContent.skillApiIntegration,
        color: AppColors.apiIntegrationColor,
        assetPath: AppAssets.apl,
        category: AppTextContent.categoryDataIntegration,
        proficiency: 4,
      ),
      SkillModel.withAsset(
        name: AppTextContent.skillUiUx,
        color: AppColors.uiUxColor,
        assetPath: AppAssets.uiux,
        category: AppTextContent.categoryFrontendUi,
        proficiency: 4,
      ),
      SkillModel.withAsset(
        name: AppTextContent.skillHttp,
        color: AppColors.httpColor,
        assetPath: AppAssets.http,
        category: AppTextContent.categoryNetworking,
        proficiency: 4,
      ),
      SkillModel.withAsset(
        name: AppTextContent.skillSqflite,
        color: AppColors.sqfliteColor,
        assetPath: AppAssets.sql,
        category: AppTextContent.categoryDatabase,
        proficiency: 4,
      ),
      SkillModel.withAsset(
        name: AppTextContent.skillHive,
        color: AppColors.hiveColor,
        assetPath: AppAssets.nodejs,
        category: AppTextContent.categoryDatabase,
        proficiency: 4,
      ),
      SkillModel.withAsset(
        name: AppTextContent.skillGithub,
        color: AppColors.githubColor,
        assetPath: AppAssets.github,
        category: AppTextContent.categoryTools,
        proficiency: 4,
      ),
      SkillModel.withAsset(
        name: AppTextContent.skillAndroidStudio,
        color: AppColors.androidStudioColor,
        assetPath: AppAssets.androidStudio,
        category: AppTextContent.categoryTools,
        proficiency: 5,
      ),
    ];
  }

  static List<SkillModel> getLearningSkills() {
    return [
      SkillModel.withAsset(
        name: AppTextContent.skillBloc,
        color: AppColors.blocColor,
        assetPath: AppAssets.javascript,
        category: AppTextContent.categoryStateManagement,
        proficiency: 3,
      ),
      SkillModel.withAsset(
        name: AppTextContent.skillDio,
        color: AppColors.dioColor,
        assetPath: AppAssets.nodejs,
        category: AppTextContent.categoryNetworking,
        proficiency: 3,
      ),
      SkillModel.withAsset(
        name: AppTextContent.skillGetx,
        color: AppColors.getxColor,
        assetPath: AppAssets.javascript,
        category: AppTextContent.categoryStateManagement,
        proficiency: 2,
      ),
      SkillModel.withAsset(
        name: AppTextContent.skillNodeJs,
        color: AppColors.nodeJsColor,
        assetPath: AppAssets.nodejs,
        category: AppTextContent.categoryFramework,
        proficiency: 2,
      ),
      SkillModel.withAsset(
        name: AppTextContent.skillPython,
        color: AppColors.pythonColor,
        assetPath: AppAssets.python,
        category: AppTextContent.categoryProgramming,
        proficiency: 3,
      ),
      SkillModel.withAsset(
        name: AppTextContent.skillSwift,
        color: AppColors.swiftColor,
        assetPath: AppAssets.swift,
        category: AppTextContent.categoryProgramming,
        proficiency: 3,
      ),
      SkillModel.withAsset(
        name: AppTextContent.skillReact,
        color: AppColors.reactColor,
        assetPath: AppAssets.react,
        category: AppTextContent.categoryFramework,
        proficiency: 2,
      ),
      SkillModel.withAsset(
        name: AppTextContent.skillJava,
        color: AppColors.hiveColor,
        assetPath: AppAssets.java,
        category: AppTextContent.categoryProgramming,
        proficiency: 2,
      ),
      SkillModel.withAsset(
        name: AppTextContent.skillGit,
        color: AppColors.getxColor,
        assetPath: AppAssets.git,
        category: AppTextContent.categoryTools,
        proficiency: 5,
      ),
    ];
  }

  static List<SkillModel> getOtherSkills() {
    return [
      SkillModel.withAsset(
        name: AppTextContent.skillHtml5,
        color: AppColors.figmaColor,
        assetPath: AppAssets.html5,
        category: AppTextContent.categoryFrontendUi,
        proficiency: 5,
      ),
      SkillModel.withAsset(
        name: AppTextContent.skillCss3,
        color: AppColors.hiveColor,
        assetPath: AppAssets.css3,
        category: AppTextContent.categoryFrontendUi,
        proficiency: 5,
      ),
      SkillModel.withAsset(
        name: AppTextContent.skillVsCode,
        color: AppColors.vsCodeColor,
        assetPath: AppAssets.nodejs,
        category: AppTextContent.categoryTools,
        proficiency: 4,
      ),
      SkillModel.withAsset(
        name: AppTextContent.skillFigma,
        color: AppColors.figmaColor,
        assetPath: AppAssets.figma,
        category: AppTextContent.categoryDesign,
        proficiency: 4,
      ),
      SkillModel.withAsset(
        name: AppTextContent.skillJavascript,
        color: AppColors.hiveColor,
        assetPath: AppAssets.javascript,
        category: AppTextContent.categoryProgramming,
        proficiency: 5,
      ),
    ];
  }

  static List<SkillModel> getAllSkills() {
    return [
      ...getCurrentSkills(),
      ...getLearningSkills(),
      ...getOtherSkills(),
    ];
  }

  static List<SkillModel> getSkillsByCategory(String category) {
    return getAllSkills()
        .where((skill) =>
    skill.category?.toLowerCase() == category.toLowerCase())
        .toList();
  }

  static List<String> getCategories() {
    return getAllSkills()
        .map((skill) => skill.category)
        .where((category) => category != null)
        .cast<String>()
        .toSet()
        .toList();
  }
}
