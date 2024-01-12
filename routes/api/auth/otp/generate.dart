import 'package:dart_frog/dart_frog.dart';
import '../../../../src/mail/smpt_mailer/smpt_mailer.dart';
import '../../../../src/mail/templates/otp_request_email_template.dart';
import '../../../../src/otp/otp.dart';

Future<Response> onRequest(RequestContext context) async {
  final otpClient = context.read<OtpClient>();
  final request = context.request;

  final queryParam = request.url.queryParameters;

  final userEmail = queryParam['email'] ?? 'viralvibes@hawkitpro.com';

  final userNameData = queryParam['userName'] ?? 'ViralVibes';

  final userName = Uri.decodeComponent(userNameData);

  final email = Uri.decodeComponent(userEmail);

  final otp = otpClient.generateOtp();

  final mail = otprequestmail(
    code: otp,
    email: email,
    userName: userName,
  );

  final mailer = SmptMailer();

  await mailer.sendMail(
    email: email,
    messageContent: mail,
    senderName: 'Viral Vibes',
    messageSubject: 'Email Verification Code 🚀',
  );

  return Response.json(
    body: 'your otp is: $otp, email = $email',
  );
}
