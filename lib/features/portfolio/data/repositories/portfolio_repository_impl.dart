import 'package:hamza_portfolio_app/core/constants/app_assets.dart';
import 'package:hamza_portfolio_app/core/constants/app_texts.dart' show AppTextContent;
import 'package:hamza_portfolio_app/features/portfolio/data/models/project_model.dart';
import 'package:hamza_portfolio_app/features/portfolio/domain/repositories/portfolio_repository.dart';

class PortfolioRepositoryImpl implements PortfolioRepository {
  static const List<Map<String, dynamic>> _projectsData = [
    {
      'id': '1',
      'title': AppTextContent.projectMenYouTitle,
      'subtitle': AppTextContent.projectMobileSubtitle,
      'description': AppTextContent.projectMenYouDescription,
      'imageAsset': AppAssets.menyoupng,
      'tags': [
        AppTextContent.skillFlutter,
        AppTextContent.skillFirebase,
        AppTextContent.skillUiUx,
      ],
    },
    {
      'id': '2',
      'title': AppTextContent.projectprayertimeTitle,
      'subtitle': AppTextContent.projectMobileSubtitle,
      'description': AppTextContent.projectprayerDescription,
      'imageAsset': AppAssets.prayertimepng,
      'tags': [
        AppTextContent.skillFlutter,
        AppTextContent.skillFirebase,
        AppTextContent.skillApiIntegration,
      ],
    },
    {
      'id': '3',
      'title': AppTextContent.projectbedtimeTitle,
      'subtitle': AppTextContent.projectMobileSubtitle,
      'description': AppTextContent.projectbedtimeDescription,
      'imageAsset': AppAssets.bedtimepng,
      'tags': [
        AppTextContent.skillFlutter,
        AppTextContent.skillHttp,
        AppTextContent.skillBloc,
      ],
    },
    {
      'id': '4',
      'title': AppTextContent.projectmentalTitle,
      'subtitle': AppTextContent.projectMobileSubtitle,
      'description': AppTextContent.projectmentalDescription,
      'imageAsset': AppAssets.mentalpng,
      'tags': [
        AppTextContent.skillFlutter,
        AppTextContent.skillApiIntegration,
        AppTextContent.skillUiUx,
      ],
    },
  ];

  @override
  Future<List<ProjectModel>> getProjects() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    return _projectsData
        .map((data) => ProjectModel.fromJson(data))
        .toList();
  }

  @override
  Future<ProjectModel?> getProjectById(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));

    try {
      final projectData = _projectsData.firstWhere((project) => project['id'] == id);
      return ProjectModel.fromJson(projectData);
    } catch (e) {
      return null;
    }
  }
}