class ProjectModel {
  final String id;
  final String title;
  final String subtitle;
  final String description;
  final String imageAsset;
  final List<String> tags;
  final String? githubUrl;
  final String? liveUrl;
  final List<String>? screenshots;

  const ProjectModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.imageAsset,
    required this.tags,
    this.githubUrl,
    this.liveUrl,
    this.screenshots,
  });

  ProjectModel copyWith({
    String? id,
    String? title,
    String? subtitle,
    String? description,
    String? imageAsset,
    List<String>? tags,
    String? githubUrl,
    String? liveUrl,
    List<String>? screenshots,
  }) {
    return ProjectModel(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      description: description ?? this.description,
      imageAsset: imageAsset ?? this.imageAsset,
      tags: tags ?? this.tags,
      githubUrl: githubUrl ?? this.githubUrl,
      liveUrl: liveUrl ?? this.liveUrl,
      screenshots: screenshots ?? this.screenshots,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'description': description,
      'imageAsset': imageAsset,
      'tags': tags,
      'githubUrl': githubUrl,
      'liveUrl': liveUrl,
      'screenshots': screenshots,
    };
  }

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      subtitle: json['subtitle'] ?? '',
      description: json['description'] ?? '',
      imageAsset: json['imageAsset'] ?? '',
      tags: List<String>.from(json['tags'] ?? []),
      githubUrl: json['githubUrl'],
      liveUrl: json['liveUrl'],
      screenshots: json['screenshots'] != null
          ? List<String>.from(json['screenshots'])
          : null,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is ProjectModel &&
              runtimeType == other.runtimeType &&
              id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'ProjectModel{id: $id, title: $title, subtitle: $subtitle}';
  }
}