String otprequestmail({
  required String email,
  required String userName,
  required String code,
}) {
  return """
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>OTP Notification</title>
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

            border-radius: 5px 5px 0 0;
            color: #FA6800;
        }

        .header h1 {
            font-size: 24px;
            font-weight: bold;
            margin: 0;
        }

        .content {
            font-size: 16px;
            line-height: 1.6;
            margin-bottom: 30px;
            background-color: #ffffff00;
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
            border-top: 1px solid #FA6800;
        }

        .footer a {
            text-decoration: none;
            color: #FA6800;
        }

        .otp {
            font-size: 20px;
            font-weight: bold;
            color: #333;
            text-align: center;
            padding: 10px 0;
            background-color: rgba(250, 104, 0, 0.06);
            border-radius: 5px;

            margin-bottom: 20px;
        }
    </style>
</head>

<body>
    <div class="email-container">
        <div class="content">
            <p>Dear <span class="header", style="font-weight: bold;">$userName</span>,</p>
            <p>Your OTP (One-Time Password) for verification is:</p>
            <div class="otp">$code</div>
            <p>This OTP will expire in 10 minutes. Please use it to complete your action or verification process.</p>
            <p>If you didn't request this OTP or have any concerns, please contact our support team immediately.</p>
            <p>Thank you for choosing Viral Vibes.</p>
            <p>Best regards,<br>Viral Vibes Team</p>
        </div>
        <div class="footer">
            <p>This email was sent to $email</p>
        </div>
    </div>
</body>

</html>
""";
}
