class ProjectModel {
  final String title;
  final String category;
  final String description;
  final List<String> technologies;
  final String image;
  final List<String> galleryImages;
  final String? playStoreUrl;
  final String? githubUrl;
  final List<String> keyFeatures;
  final List<String> responsibilities;

  const ProjectModel({
    required this.title,
    required this.category,
    required this.description,
    required this.technologies,
    required this.image,
    this.galleryImages = const [],
    this.playStoreUrl,
    this.githubUrl,
    this.keyFeatures = const [],
    this.responsibilities = const [],
  });
}