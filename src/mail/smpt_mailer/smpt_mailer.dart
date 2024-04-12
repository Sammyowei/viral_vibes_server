// ignore_for_file: strict_raw_type

import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

import '../smpt_client.dart';

class SmptMailer {
  SmptMailer() {
    _init();
  }
  final _smptClient = SmptClient();

  void _init() {
    _smptClient
      ..smptEmail = 'viralvibes@hawkitpro.com'
      ..smptPassword = 'rqex ozor eski cvqk';
  }

  SmtpServer _smtpServer() {
    final smpt = SmtpServer(
      'smtp.gmail.com',
      username: _smptClient.smptEmail,
      password: _smptClient.smptPassword,
      ssl: true,
      port: 465,
      ignoreBadCertificate: true,
    );
    return smpt;
  }

  Future<void> sendMail({
    required String email,
    required String senderName,
    required String messageContent,
    required String messageSubject,
  }) async {
    final smtpServer = _smtpServer();
    final message = Message()
      ..from = Address(
        _smptClient.smptEmail,
        senderName,
      )
      ..recipients.add(email)
      ..subject = messageSubject
      ..html = messageContent;

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: $sendReport');
    } on MailerException catch (e) {
      print('Message not sent.  ${e.message}');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
  }

  Future<void> sendBulkMail({
    required List<String> email,
    required String senderName,
    required String messageContent,
    required String messageSubject,
  }) async {
    final smtpServer = _smtpServer();
    final message = Message()
      ..from = Address(
        _smptClient.smptEmail,
        senderName,
      )
      ..recipients.addAll(email)
      ..subject = messageSubject
      ..html = messageContent;

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: $sendReport');
    } on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
  }
}
