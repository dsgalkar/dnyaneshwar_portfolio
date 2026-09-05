/// Data Model for Multiple Tailored Resumes with In-App Preview Metadata
class ResumeModel {
  final String id;
  final String title;
  final String roleFocus; // e.g. 'Flutter & Mobile', 'Cybersecurity & Systems', 'Full Stack'
  final String lastUpdated;
  final String url;
  final String fileSize;
  final List<String> summaryPoints;
  final bool isPrimary;
  final String badge;

  const ResumeModel({
    required this.id,
    required this.title,
    required this.roleFocus,
    required this.lastUpdated,
    required this.url,
    this.fileSize = '145 KB',
    required this.summaryPoints,
    this.isPrimary = false,
    this.badge = 'PDF',
  });

  ResumeModel copyWith({
    String? id,
    String? title,
    String? roleFocus,
    String? lastUpdated,
    String? url,
    String? fileSize,
    List<String>? summaryPoints,
    bool? isPrimary,
    String? badge,
  }) {
    return ResumeModel(
      id: id ?? this.id,
      title: title ?? this.title,
      roleFocus: roleFocus ?? this.roleFocus,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      url: url ?? this.url,
      fileSize: fileSize ?? this.fileSize,
      summaryPoints: summaryPoints ?? this.summaryPoints,
      isPrimary: isPrimary ?? this.isPrimary,
      badge: badge ?? this.badge,
    );
  }
}
