import 'package:intl/intl.dart';

String loginEmailNotificationTemplate({
  required String email,
  required String userName,
}) {
  final date = DateTime.now();
  final formattedDate = DateFormat('dd - MMMM - yyyy').format(date);
  final formattedTime = DateFormat('HH:mm:ss').format(date);

  final timeZone = date.timeZoneName;
  final dateTime = '$formattedDate $formattedTime $timeZone';
  return """

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>Login Notification</title>
    <style>
        /* Reset default margin and padding */
        body,
        h1,
        p {
            margin: 0;
            padding: 0;
        }

        /* Styles for the email content */
        .email-container {
            max-width: 600px;
            margin: 20px auto;
            font-family: Arial, sans-serif;
            background-color: #f9f9f9;
            border: 1px solid #ddd;
            border-radius: 5px;
            padding: 20px;
        }

        .header {

            padding: 10px 20px;
            border-radius: 5px 5px 0 0;
        }

        .header h1 {
            font-size: 24px;
            margin: 0;
        }

        .content {
            font-size: 16px;
            line-height: 1.6;
            margin-bottom: 30px;
            /* border-top: 1px solid #FA6800; */
            border-bottom: 1px solid #FA6800;
            padding: 20px 0;
        }

        .content p {
            margin-bottom: 20px;
        }

        .footer {
            font-size: 14px;
            color: #666;
            text-align: center;
            padding: 20px 0;
            border-radius: 0 0 5px 5px;
            /* border-top: 1px solid #FA6800; */
        }

        .footer a {
            text-decoration: none;
            color: #FA6800;
        }

        .footertext {
            color: #FA6800;
        }

        .userName {
            color: #FA6800;
            font-weight: 900;

        }

        .dateTime {
            font-weight: 900;
        }
    </style>
</head>

<body>
    <div class="email-container">

        <div class="content">
            <p>Dear <span class="userName">$userName</span>,</p>
            <p>This is to inform you that your Viral Vibes account was accessed at <span
                    class="dateTime">$dateTime</span> </p>
            <p>If you initiated this login, you can disregard this message. However, if you didn't recognize this
                activity or suspect any unauthorized access, please take immediate action by changing your password and
                reviewing your account's recent activity.</p>
            <p>For any concerns or assistance regarding your account's security, our support team is here to help.
                Please contact us at <span class="userName"><a href="mailto:viralvibes@hawkitpro.com" ,
                        class="userName">viral vibes support</a></span>
            </p>
            <p>Thank you for choosing Viral Vibes. We prioritize your account security and strive to ensure a
                safe experience for all our users.</p>
            <p>Best regards,<br>Viral Vibes Team</p>
        </div>
        <div class="footer">
            <p>This email was sent to <span class="footertext">$email</span> </p>
        </div>
    </div>
</body>

</html>
""";
}
