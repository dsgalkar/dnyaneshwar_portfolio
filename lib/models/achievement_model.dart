/// Data model for Achievements, Certifications & Competitions
class AchievementModel {
  final String title;
  final String issuer;
  final String date;
  final String description;
  final String category; // 'Competition', 'Certification', 'Hackathon', 'Academic'
  final String badgeIcon;
  final String? credentialUrl;
  final List<String> skillsGained;

  const AchievementModel({
    required this.title,
    required this.issuer,
    required this.date,
    required this.description,
    required this.category,
    required this.badgeIcon,
    this.credentialUrl,
    required this.skillsGained,
  });
}
