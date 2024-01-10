String accountCreationEmailTemplate({required String email}) {
  return """
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>Account Creation Notification</title>
    <style>
        /* Reset default margin and padding */
        body,
        h1,
        p {
            margin: 0;
            padding: 0;
            font-family: 'Nunito', sans-serif;
            /* Applying Nunito font to all elements */
        }

        /* Importing Nunito font from Google Fonts */
        @import url('https://fonts.googleapis.com/css2?family=Nunito:wght@400;700&display=swap');

        /* Styles for the email content */
        .email-container {
            max-width: 600px;
            margin: 20px auto;
            font-family: 'Nunito', sans-serif;
            background-color: #f9f9f9;
            border: 1px solid #ddd;
            border-radius: 5px;
            padding: 20px;  
        }

        .header {
            padding: 10px 20px;
            border-radius: 5px 5px 5px 5px;
            background-color: #FA6800;
            color: #fff;
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
    </style>
</head>

<body>
    <div class="email-container">

        <div class="content">
            <p>Dear Viber,</p>
            <p>Your account has been successfully created with Viral Vibes.</p>
            <p>We are incredibly excited to have you onboard! Thank you for choosing Viral Vibes as your number one
                Social Media Marketing agency.</p>
            <p>If you have any questions or need assistance, feel free to contact our support team.</p>
            <p>Best regards,<br>Viral Vibes Team</p>
            <p>Let's go viral!</p>
        </div>
        <div class="footer">
            <p>This email was sent to $email</p>
        </div>
    </div>
</body>

</html>
""";
}
