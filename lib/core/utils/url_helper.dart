import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

/// Helper to safely open external links and mailto triggers
class UrlHelper {
  UrlHelper._();

  static Future<bool> launchURL(String urlString) async {
    try {
      final Uri uri = Uri.parse(urlString);
      if (await canLaunchUrl(uri)) {
        return await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        debugPrint('Could not launch $urlString');
        return false;
      }
    } catch (e) {
      debugPrint('Error launching URL $urlString: $e');
      return false;
    }
  }

  static Future<bool> sendEmail(String email, {String subject = '', String body = ''}) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: {
        if (subject.isNotEmpty) 'subject': subject,
        if (body.isNotEmpty) 'body': body,
      },
    );
    try {
      return await launchUrl(emailUri);
    } catch (e) {
      debugPrint('Error opening email client: $e');
      return false;
    }
  }
}
