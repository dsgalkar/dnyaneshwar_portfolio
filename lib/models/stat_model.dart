/// Model for animated statistics counters
class StatModel {
  final int count;
  final String suffix;
  final String label;
  final String icon;

  const StatModel({
    required this.count,
    this.suffix = '+',
    required this.label,
    required this.icon,
  });
}
