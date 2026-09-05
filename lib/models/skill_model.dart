enum SkillCategory {
  programming('Programming', '💻'),
  appDev('App Development', '📱'),
  web('Web & APIs', '🌐'),
  cybersecurity('Cybersecurity & OS', '🛡️'),
  data('Data & Analytics', '📊'),
  tools('DevOps & Tools', '⚙️');

  final String label;
  final String icon;
  const SkillCategory(this.label, this.icon);
}

/// Data model for interactive skill nodes
class SkillModel {
  final String name;
  final SkillCategory category;
  final double proficiency; // 0.0 to 1.0
  final String description;
  final List<String> relatedTech;
  final List<String> usedInProjects;
  final String iconKey;

  const SkillModel({
    required this.name,
    required this.category,
    required this.proficiency,
    required this.description,
    required this.relatedTech,
    required this.usedInProjects,
    this.iconKey = 'code',
  });
}
