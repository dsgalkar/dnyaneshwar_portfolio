/// Model representing an incoming contact form inquiry in the admin control center
class ContactMessageModel {
  final String id;
  final String senderName;
  final String senderEmail;
  final String subject;
  final String message;
  final DateTime timestamp;
  final bool isRead;

  const ContactMessageModel({
    required this.id,
    required this.senderName,
    required this.senderEmail,
    this.subject = 'Direct Portfolio Inquiry',
    required this.message,
    required this.timestamp,
    this.isRead = false,
  });

  ContactMessageModel copyWith({
    String? id,
    String? senderName,
    String? senderEmail,
    String? subject,
    String? message,
    DateTime? timestamp,
    bool? isRead,
  }) {
    return ContactMessageModel(
      id: id ?? this.id,
      senderName: senderName ?? this.senderName,
      senderEmail: senderEmail ?? this.senderEmail,
      subject: subject ?? this.subject,
      message: message ?? this.message,
      timestamp: timestamp ?? this.timestamp,
      isRead: isRead ?? this.isRead,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'senderName': senderName,
      'senderEmail': senderEmail,
      'subject': subject,
      'message': message,
      'timestamp': timestamp.toIso8601String(),
      'isRead': isRead,
    };
  }

  factory ContactMessageModel.fromJson(Map<String, dynamic> json) {
    return ContactMessageModel(
      id: json['id'] as String,
      senderName: json['senderName'] as String,
      senderEmail: json['senderEmail'] as String,
      subject: json['subject'] as String? ?? 'Direct Portfolio Inquiry',
      message: json['message'] as String,
      timestamp: DateTime.tryParse(json['timestamp'] as String? ?? '') ?? DateTime.now(),
      isRead: json['isRead'] as bool? ?? false,
    );
  }
}
