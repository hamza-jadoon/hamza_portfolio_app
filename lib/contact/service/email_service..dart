// ignore_for_file: unused_element, avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;

class EmailJSService {
  // Replace these with your EmailJS credentials
  static const String _serviceId = 'service_6dksocv';
  static const String _templateId = 'template_y9hmrvr';
  static const String _publicKey = 'N1OLePK9OWrJyMqzf';
  static const String _privateKey = 'YOUR_PRIVATE_KEY'; // Optional for additional security

  static const String _emailJSUrl = 'https://api.emailjs.com/api/v1.0/email/send';

  static Future<bool> sendEmail({
    required String fromName,
    required String fromEmail,
    required String subject,
    required String message,
    String? toEmail,
  }) async {
    try {
      final emailData = {
        'service_id': _serviceId,
        'template_id': _templateId,
        'user_id': _publicKey,
        'template_params': {
          'user_name': fromName,
          'user_email': fromEmail,
          'user_subject': subject,
          'user_message': message,
          'to_email': toEmail ?? 'jadoonkhan4455@gmail.com',
          'reply_to': fromEmail,
          // Additional fields for better email formatting
          'from_name': fromName,
          'from_email': fromEmail,
          'subject': subject,
          'message': message,
        },
        if (_privateKey.isNotEmpty) 'accessToken': _privateKey,
      };

      final response = await http.post(
        Uri.parse(_emailJSUrl),
        headers: {
          'Content-Type': 'application/json',
          'origin': 'http://localhost', // For Flutter web
        },
        body: json.encode(emailData),
      );

      if (response.statusCode == 200) {
        print('Email sent successfully!');
        return true;
      } else {
        print('Failed to send email. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error sending email: $e');
      return false;
    }
  }

  /// Initialize EmailJS (optional method for additional setup)
  static Future<void> init() async {
    // You can add any initialization logic here if needed
    print('EmailJS Service initialized');
  }

  /// Create formatted email body
  static String _createEmailBody({
    required String name,
    required String email,
    required String subject,
    required String message,
  }) {
    final DateTime now = DateTime.now();
    final String formattedDate = '${now.day}/${now.month}/${now.year} at ${now.hour}:${now.minute.toString().padLeft(2, '0')}';

    return '''
═══════════════════════════════════════
📧 NEW CONTACT FORM SUBMISSION
═══════════════════════════════════════

👤 SENDER INFORMATION:
   Name: $name
   Email: $email
   Date: $formattedDate

📝 MESSAGE DETAILS:
   Subject: $subject

💬 MESSAGE:
$message

═══════════════════════════════════════
📱 Sent from Portfolio Website
═══════════════════════════════════════

Reply directly to this email to respond to $name.
    ''';
  }
}