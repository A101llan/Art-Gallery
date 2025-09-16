<?php
// env.php - Environment variables for M-Pesa integration
// Add this to your php.ini: auto_prepend_file = "C:/xampp/htdocs/usanii_mashariki/env.php"

// M-Pesa Daraja API Configuration
// Replace these with your actual credentials from https://developer.safaricom.co.ke/

// Environment (sandbox or production)
putenv('MPESA_ENV=sandbox');

// Your Daraja API credentials
putenv('MPESA_CONSUMER_KEY=rtPbPtUNu2LWba6N0ALdBvEcEJz9GXjs7lRdxG9vGbpxbXBk');
putenv('MPESA_CONSUMER_SECRET=1gAUjltTFG8jeGAw54qw9yQIcQJfyaTAcaShS9kb173KyWpGR2cepzwV56mlGO6t');

// Your business shortcode (Paybill or Till number)
putenv('MPESA_SHORTCODE=174379'); // Your correct shortcode

// Your passkey from Daraja portal (using sandbox test passkey for 174379)
putenv('MPESA_PASSKEY=bfb279f9aa9bdbcf158e97dd71a467cd2e0c893059b10f78e6b72ada1ed2c919');

// Your callback base URL (must be publicly accessible)
// IMPORTANT: This URL must be publicly accessible from the internet
// For local development, use ngrok or similar service
// For production, use your actual domain
putenv('MPESA_CALLBACK_BASE_URL=https://105961daefef.ngrok-free.app');

/*
INSTRUCTIONS:

1. Get your credentials from: https://developer.safaricom.co.ke/
2. Replace the values above with your actual credentials
3. For testing, use sandbox environment first
4. Ensure your callback URL is publicly accessible (use ngrok for local testing)

FOR LOCAL TESTING WITH NGROK:
1. Install ngrok: https://ngrok.com/
2. Run: ngrok http 80
3. Update the callback URL to your ngrok URL:
   putenv('MPESA_CALLBACK_BASE_URL=https://your-ngrok-url.ngrok.io');
4. Make sure to update this URL whenever ngrok restarts

FOR PRODUCTION:
1. Use your actual domain:
   putenv('MPESA_CALLBACK_BASE_URL=https://yourdomain.com');
2. Ensure your server is publicly accessible
3. Update MPESA_ENV to 'production'
4. Use your production credentials

SAMPLE SANDBOX CREDENTIALS (for testing only):
putenv('MPESA_ENV=sandbox');
putenv('MPESA_CONSUMER_KEY=your_sandbox_consumer_key');
putenv('MPESA_CONSUMER_SECRET=your_sandbox_consumer_secret');
putenv('MPESA_SHORTCODE=174379');
putenv('MPESA_PASSKEY=your_sandbox_passkey');
putenv('MPESA_CALLBACK_BASE_URL=https://your-ngrok-url.ngrok.io');

TROUBLESHOOTING:
- If payments don't appear after completion, check the error logs
- Ensure the callback URL is accessible from the internet
- Verify that the payments and purchase_history tables exist
- Check that the M-Pesa credentials are correct
*/
