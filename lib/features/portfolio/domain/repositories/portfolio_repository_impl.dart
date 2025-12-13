import 'package:hamza_portfolio_app/core/constants/app_assets.dart';
import 'package:hamza_portfolio_app/core/breakpoints/app_texts.dart' show AppTextContent;
import 'package:hamza_portfolio_app/features/portfolio/data/models/project_model.dart';
import 'package:hamza_portfolio_app/features/portfolio/domain/repositories/portfolio_repository.dart';

class PortfolioRepositoryImpl implements PortfolioRepository {
  static final List<Map<String, dynamic>> _projectsData = [
    const {
      'id': '1',
      'title': AppTextContent.plannerapp,
      'subtitle': AppTextContent.projectMobileSubtitle,
      'description': AppTextContent.plannerappDescription,
      'imageAsset': AppAssets.planner,
      'tags': [
        AppTextContent.skillFlutter,
        AppTextContent.development,
        AppTextContent.skillUiUx,
        AppTextContent.categoryDesign,
        AppTextContent.skillHive,
      ],
      'liveUrl': 'https://play.google.com/store/apps/details?id=hivesoft.menu.grocery.planner.shopping.larder.list&hl=en',
      // 'githubUrl': 'https://github.com/yourusername/planner-app',
    },
    const {
      'id': '2',
      'title': AppTextContent.projectMenYouTitle,
      'subtitle': AppTextContent.projectMobileSubtitle,
      'description': AppTextContent.projectMenYouDescription,
      'imageAsset': AppAssets.menyoupng,
      'tags': [
        AppTextContent.skillFlutter,
        AppTextContent.skillFirebase,
        AppTextContent.skillUiUx,
        AppTextContent.skillApiIntegration,
        AppTextContent.riverpod,
      ],
      'liveUrl': 'https://play.google.com/store/apps/details?id=hivesoft.menu.grocery.planner.shopping.larder.list&hl=en',

    },
    const {
      'id': '3',
      'title': AppTextContent.projectprayertimeTitle,
      'subtitle': AppTextContent.projectMobileSubtitle,
      'description': AppTextContent.projectprayerDescription,
      'imageAsset': AppAssets.prayertimepng,
      'tags': [
        AppTextContent.skillFlutter,
        AppTextContent.skillFirebase,
        AppTextContent.skillApiIntegration,
        AppTextContent.skillLocalNotification,
        AppTextContent.skillCleanArchitecture,
      ],
      'liveUrl': 'https://play.google.com/store/apps/details?id=hivesoft.menu.grocery.planner.shopping.larder.list&hl=en',

    },
    const {
      'id': '4',
      'title': AppTextContent.projectbedtimeTitle,
      'subtitle': AppTextContent.projectMobileSubtitle,
      'description': AppTextContent.projectbedtimeDescription,
      'imageAsset': AppAssets.bedtimepng,
      'tags': [
        AppTextContent.skillFlutter,
        AppTextContent.skillUiUx,
        AppTextContent.skillBloc,
        AppTextContent.skillAnimations,
        AppTextContent.skillDatabase,
      ],
      'liveUrl': 'https://play.google.com/store/apps/details?id=hivesoft.menu.grocery.planner.shopping.larder.list&hl=en',

    },
    const {
      'id': '5',
      'title': AppTextContent.projectmentalTitle,
      'subtitle': AppTextContent.projectMobileSubtitle,
      'description': AppTextContent.projectmentalDescription,
      'imageAsset': AppAssets.mentalpng,
      'tags': [
        AppTextContent.skillFlutter,
        AppTextContent.skillApiIntegration,
        AppTextContent.skillUiUx,
        AppTextContent.skillAuthentication,
        AppTextContent.skillHttp,
      ],
      'liveUrl': 'https://play.google.com/store/apps/details?id=hivesoft.menu.grocery.planner.shopping.larder.list&hl=en',

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