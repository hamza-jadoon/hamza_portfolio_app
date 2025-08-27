import 'package:flutter/material.dart';
import 'package:hamza_portfolio_app/core/constants/app_assets.dart';
import 'package:hamza_portfolio_app/core/constants/app_colors.dart';
import 'package:hamza_portfolio_app/core/constants/app_texts.dart';
import 'package:hamza_portfolio_app/features/portfolio/data/models/skill_model.dart';

class SkillsData {
  static List<SkillModel> getCurrentSkills() {
    return [
      SkillModel.withSvg(
        name: AppTextContent.skillFlutter,
        color: AppColors.flutterColor,
        svgPath: AppAssets.flutter,
        category: AppTextContent.categoryFramework,
        proficiency: 5,
      ),
      SkillModel.withSvg(
        name: AppTextContent.skillDart,
        color: AppColors.dartColor,
        svgPath: AppAssets.dart,
        category: AppTextContent.categoryProgramming,
        proficiency: 5,
      ),
      SkillModel.withSvg(
        name: AppTextContent.skillFirebase,
        color: AppColors.firebaseColor,
        svgPath: AppAssets.firebase,
        category: AppTextContent.categoryBackend,
        proficiency: 4,
      ),
      SkillModel.withSvg(
        name: AppTextContent.skillApiIntegration,
        color: AppColors.apiIntegrationColor,
        svgPath: AppAssets.apl,
        category: AppTextContent.categoryDataIntegration,
        proficiency: 4,
      ),
      SkillModel.withSvg(
        name: AppTextContent.skillUiUx,
        color: AppColors.uiUxColor,
        svgPath: AppAssets.defaultSkill,
        category: AppTextContent.categoryFrontendUi,
        proficiency: 4,
      ),
      SkillModel.withSvg(
        name: AppTextContent.skillHttp,
        color: AppColors.httpColor,
        svgPath: AppAssets.defaultSkill,
        category: AppTextContent.categoryNetworking,
        proficiency: 4,
      ),
      SkillModel.withSvg(
        name: AppTextContent.skillSqflite,
        color: AppColors.sqfliteColor,
        svgPath: AppAssets.defaultSkill,
        category: AppTextContent.categoryDatabase,
        proficiency: 4,
      ),
      SkillModel.withSvg(
        name: AppTextContent.skillHive,
        color: AppColors.hiveColor,
        svgPath: AppAssets.defaultSkill,
        category: AppTextContent.categoryDatabase,
        proficiency: 4,
      ),
      SkillModel.withSvg(
        name: AppTextContent.skillGithub,
        color: AppColors.githubColor,
        svgPath: AppAssets.github,
        category: AppTextContent.categoryTools,
        proficiency: 4,
      ),
      SkillModel.withSvg(
        name: AppTextContent.skillAndroidStudio,
        color: AppColors.androidStudioColor,
        svgPath: AppAssets.androidStudio,
        category: AppTextContent.categoryTools,
        proficiency: 5,
      ),
    ];
  }

  static List<SkillModel> getLearningSkills() {
    return [
      SkillModel.withSvg(
        name: AppTextContent.skillBloc,
        color: AppColors.blocColor,
        svgPath: AppAssets.defaultSkill,
        category: AppTextContent.categoryStateManagement,
        proficiency: 3,
      ),
      SkillModel.withSvg(
        name: AppTextContent.skillDio,
        color: AppColors.dioColor,
        svgPath: AppAssets.defaultSkill,
        category: AppTextContent.categoryNetworking,
        proficiency: 3,
      ),
      SkillModel.withSvg(
        name: AppTextContent.skillGetx,
        color: AppColors.getxColor,
        svgPath: AppAssets.defaultSkill,
        category: AppTextContent.categoryStateManagement,
        proficiency: 2,
      ),
      SkillModel.withSvg(
        name: AppTextContent.skillNodeJs,
        color: AppColors.nodeJsColor,
        svgPath: AppAssets.nodejs,
        category: AppTextContent.categoryFramework,
        proficiency: 2,
      ),
      SkillModel.withSvg(
        name: AppTextContent.skillPython,
        color: AppColors.pythonColor,
        svgPath: AppAssets.python,
        category: AppTextContent.categoryProgramming,
        proficiency: 3,
      ),
      SkillModel.withSvg(
        name: AppTextContent.skillSwift,
        color: AppColors.swiftColor,
        svgPath: AppAssets.swift,
        category: AppTextContent.categoryProgramming,
        proficiency: 3,
      ),
      SkillModel.withSvg(
        name: AppTextContent.skillReact,
        color: AppColors.reactColor,
        svgPath: AppAssets.react,
        category: AppTextContent.categoryFramework,
        proficiency: 2,
      ),
      SkillModel.withSvg(
        name: AppTextContent.skillJava,
        color: AppColors.javaColor,
        svgPath: AppAssets.java,
        category: AppTextContent.categoryProgramming,
        proficiency: 2,
      ),
      SkillModel.withSvg(
        name: AppTextContent.skillGit,
        color: AppColors.sharedPrefColor,
        svgPath: AppAssets.git,
        category: AppTextContent.categoryTools,
        proficiency: 5,
      ),
    ];
  }

  static List<SkillModel> getOtherSkills() {
    return [
      SkillModel.withSvg(
        name: AppTextContent.skillHtml5,
        color: AppColors.html5Color,
        svgPath: AppAssets.html5,
        category: AppTextContent.categoryFrontendUi,
        proficiency: 5,
      ),
      SkillModel.withSvg(
        name: AppTextContent.skillCss3,
        color: AppColors.cssColor,
        svgPath: AppAssets.css3,
        category: AppTextContent.categoryFrontendUi,
        proficiency: 5,
      ),
      SkillModel.withSvg(
        name: AppTextContent.skillVsCode,
        color: AppColors.vsCodeColor,
        svgPath: AppAssets.vscode,
        category: AppTextContent.categoryTools,
        proficiency: 4,
      ),
      SkillModel.withSvg(
        name: AppTextContent.skillFigma,
        color: AppColors.figmaColor,
        svgPath: AppAssets.figma,
        category: AppTextContent.categoryDesign,
        proficiency: 4,
      ),
      // SkillModel.withSvg(
      //   name: 'SHARED PREF',
      //   color: AppColors.sharedPrefColor,
      //   svgPath: 'assets/icons/shared_preferences.svg',
      //   category: 'Storage',
      //   proficiency: 5,
      // ),
      SkillModel.withSvg(
        name: AppTextContent.skillJavascript,
        color: AppColors.javascriptColor,
        svgPath: AppAssets.javascript,
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
        .where((skill) => skill.category?.toLowerCase() == category.toLowerCase())
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