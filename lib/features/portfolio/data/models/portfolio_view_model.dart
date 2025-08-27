import 'package:flutter/foundation.dart';
import 'package:hamza_portfolio_app/features/portfolio/data/models/project_model.dart';
import 'package:hamza_portfolio_app/features/portfolio/domain/repositories/portfolio_repository.dart';
import 'package:hamza_portfolio_app/features/portfolio/presentation/state/portfolio_state.dart';

class PortfolioViewModel extends ChangeNotifier {
  final PortfolioRepository _repository;

  PortfolioState _state = const PortfolioState();
  PortfolioState get state => _state;

  PortfolioViewModel({required PortfolioRepository repository})
      : _repository = repository;

  void _updateState(PortfolioState newState) {
    _state = newState;
    notifyListeners();
  }

  Future<void> loadProjects() async {
    if (_state.status == PortfolioStatus.loading) return;

    _updateState(_state.copyWith(status: PortfolioStatus.loading));

    try {
      final projects = await _repository.getProjects();
      _updateState(_state.copyWith(
        status: PortfolioStatus.loaded,
        projects: projects,
        errorMessage: null,
      ));
    } catch (e) {
      _updateState(_state.copyWith(
        status: PortfolioStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> selectProject(String projectId) async {
    try {
      final project = await _repository.getProjectById(projectId);
      _updateState(_state.copyWith(selectedProject: project));
    } catch (e) {
      debugPrint('Error selecting project: $e');
    }
  }

  void clearSelectedProject() {
    _updateState(_state.copyWith(selectedProject: null));
  }

  void setAnimating(bool isAnimating) {
    _updateState(_state.copyWith(isAnimating: isAnimating));
  }

  // Getters for computed properties
  bool get isLoading => _state.status == PortfolioStatus.loading;
  bool get hasError => _state.status == PortfolioStatus.error;
  bool get hasProjects => _state.projects.isNotEmpty;
  List<ProjectModel> get projects => _state.projects;
  ProjectModel? get selectedProject => _state.selectedProject;
  String? get errorMessage => _state.errorMessage;
}
