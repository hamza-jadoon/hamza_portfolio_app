import 'package:hamza_portfolio_app/core/constants/app_texts.dart' show AppTextContent;
import 'package:hamza_portfolio_app/features/portfolio/data/models/project_model.dart';
import 'package:hamza_portfolio_app/features/portfolio/domain/repositories/portfolio_repository.dart';

class PortfolioRepositoryImpl implements PortfolioRepository {
  static const List<Map<String, dynamic>> _projectsData = [
    {
      'id': '1',
      'title': 'Men YOU – AI-Powered Food Calorie Scanner App',
      'subtitle': 'Mobile Application',
      'description': '''
The core feature of the app is an AI-powered food scanning tool that uses Gemini API to analyze food images — either captured through the camera or selected from the gallery.
The AI processes the image and displays real-time calorie and nutrition estimates to the user. This helps health-conscious users monitor their intake with ease and convenience.
          ''',
      'imageAsset': 'assets/ecommerce_mockup.png',
      'tags': [
        AppTextContent.skillFlutter,
        AppTextContent.skillFirebase,
        AppTextContent.skillUiUx,
      ],
    },
    {
      'id': '2',
      'title': 'Real-time Chat Application',
      'subtitle': 'Mobile Application',
      'description': 'A modern real-time chat application with end-to-end encryption, file sharing, group chats, and push notifications. Built with Flutter for cross-platform compatibility.',
      'imageAsset': 'assets/chat_mockup.png',
      'tags': [
        AppTextContent.skillFlutter,
        AppTextContent.skillFirebase,
        AppTextContent.skillApiIntegration,
      ],
    },
    {
      'id': '3',
      'title': 'Task Management Dashboard',
      'subtitle': 'Mobile Application',
      'description': 'A comprehensive task management system with team collaboration features, project tracking, time logging, and analytics dashboard. Built with responsive design for optimal user experience across all devices.',
      'imageAsset': 'assets/dashboard_mockup.png',
      'tags': [
        AppTextContent.skillFlutter,
        AppTextContent.skillHttp,
        AppTextContent.skillBloc,
      ],
    },
    {
      'id': '4',
      'title': 'Weather Forecast App',
      'subtitle': 'Mobile Application',
      'description': 'Modern weather application with location-based forecasts, interactive maps, weather alerts, and beautiful animated UI. Integrates with multiple weather APIs for accurate and up-to-date information.',
      'imageAsset': 'assets/weather_mockup.png',
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
