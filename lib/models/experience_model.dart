/// Data model for Timeline Experience, Activities, and Leadership milestones
class ExperienceModel {
  final String title;
  final String organization;
  final String period;
  final String roleType; // 'Leadership', 'Hackathon', 'Community', 'Academic', 'Internship'
  final String description;
  final List<String> highlights;
  final List<String> tags;
  final String icon;

  const ExperienceModel({
    required this.title,
    required this.organization,
    required this.period,
    required this.roleType,
    required this.description,
    required this.highlights,
    required this.tags,
    this.icon = '💼',
  });
}
