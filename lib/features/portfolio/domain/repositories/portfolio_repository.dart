
import 'package:hamza_portfolio_app/features/portfolio/data/models/project_model.dart';

abstract class PortfolioRepository {
  Future<List<ProjectModel>> getProjects();
  Future<ProjectModel?> getProjectById(String id);
}