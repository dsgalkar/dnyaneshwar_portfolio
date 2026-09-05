/// Data model for VAMINT Community Initiatives & Events
class ActivityModel {
  final String title;
  final String eventType;
  final String date;
  final String description;
  final String impact;
  final List<String> tags;
  final String icon;

  const ActivityModel({
    required this.title,
    required this.eventType,
    required this.date,
    required this.description,
    required this.impact,
    required this.tags,
    this.icon = '⚡',
  });
}
