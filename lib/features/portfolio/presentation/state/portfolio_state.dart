import 'package:flutter/foundation.dart';
import 'package:hamza_portfolio_app/features/portfolio/data/models/project_model.dart';

enum PortfolioStatus { initial, loading, loaded, error }

@immutable
class PortfolioState {
  final PortfolioStatus status;
  final List<ProjectModel> projects;
  final String? errorMessage;
  final ProjectModel? selectedProject;
  final bool isAnimating;

  const PortfolioState({
    this.status = PortfolioStatus.initial,
    this.projects = const [],
    this.errorMessage,
    this.selectedProject,
    this.isAnimating = false,
  });

  PortfolioState copyWith({
    PortfolioStatus? status,
    List<ProjectModel>? projects,
    String? errorMessage,
    ProjectModel? selectedProject,
    bool? isAnimating,
  }) {
    return PortfolioState(
      status: status ?? this.status,
      projects: projects ?? this.projects,
      errorMessage: errorMessage ?? this.errorMessage,
      selectedProject: selectedProject ?? this.selectedProject,
      isAnimating: isAnimating ?? this.isAnimating,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is PortfolioState &&
              runtimeType == other.runtimeType &&
              status == other.status &&
              listEquals(projects, other.projects) &&
              errorMessage == other.errorMessage &&
              selectedProject == other.selectedProject &&
              isAnimating == other.isAnimating;

  @override
  int get hashCode => Object.hash(
    status,
    Object.hashAll(projects),
    errorMessage,
    selectedProject,
    isAnimating,
  );
}