/// Data Model for Projects with deep case-study architecture breakdown
class ProjectModel {
  final String id;
  final String title;
  final String tagline;
  final String description;
  final String problem;
  final String solution;
  final List<String> features;
  final List<String> technologies;
  final String architecture;
  final String challenges;
  final String learnings;
  final String? githubUrl;
  final String? liveDemoUrl;
  final String category; // 'Mobile', 'Full Stack', 'Cybersecurity', 'AI / Data'
  final bool isFeatured;
  final String iconSymbol;

  const ProjectModel({
    required this.id,
    required this.title,
    required this.tagline,
    required this.description,
    required this.problem,
    required this.solution,
    required this.features,
    required this.technologies,
    required this.architecture,
    required this.challenges,
    required this.learnings,
    this.githubUrl,
    this.liveDemoUrl,
    required this.category,
    this.isFeatured = false,
    this.iconSymbol = '🚀',
  });
}
