<?php
// utils/MpesaDaraja.php - Safaricom Daraja (M-Pesa) helper

class MpesaDaraja {
    private string $env;
    private string $consumerKey;
    private string $consumerSecret;
    private string $shortcode;
    private string $passkey;
    private string $callbackBaseUrl;

    public function __construct() {
        $this->env = trim(getenv('MPESA_ENV') ?: 'sandbox');
        $this->consumerKey = trim(getenv('MPESA_CONSUMER_KEY') ?: '');
        $this->consumerSecret = trim(getenv('MPESA_CONSUMER_SECRET') ?: '');
        $this->shortcode = trim(getenv('MPESA_SHORTCODE') ?: '');
        $this->passkey = trim(getenv('MPESA_PASSKEY') ?: '');
        $this->callbackBaseUrl = rtrim(trim(getenv('MPESA_CALLBACK_BASE_URL') ?: ''), '/');
    }

    private function baseUrl(): string {
        return $this->env === 'production' ? 'https://api.safaricom.co.ke' : 'https://sandbox.safaricom.co.ke';
    }

    public function getAccessToken(): array {
        $url = $this->baseUrl() . '/oauth/v1/generate?grant_type=client_credentials';

        $ch = curl_init($url);
        curl_setopt($ch, CURLOPT_HTTPHEADER, ['Content-Type: application/json; charset=utf-8']);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_USERPWD, $this->consumerKey . ':' . $this->consumerSecret);
        $response = curl_exec($ch);
        $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
        $err = curl_error($ch);
        curl_close($ch);

        if ($err || $httpCode >= 400) {
            return ['success' => false, 'message' => 'OAuth failed', 'error' => $err, 'status' => $httpCode, 'body' => $response];
        }

        $data = json_decode($response, true);
        if (!isset($data['access_token'])) {
            return ['success' => false, 'message' => 'OAuth token missing', 'raw' => $response];
        }
        return ['success' => true, 'access_token' => $data['access_token']];
    }

    public function stkPush(int $amount, string $phoneNumber, string $accountReference, string $transactionDesc, string $callbackPath = '/usanii_mashariki/api/payments/mpesa/callback'): array {
        $tokenResult = $this->getAccessToken();
        if (!$tokenResult['success']) {
            return $tokenResult;
        }
        $accessToken = $tokenResult['access_token'];

        $timestamp = date('YmdHis');
        $password = base64_encode($this->shortcode . $this->passkey . $timestamp);

        $callbackUrl = $this->callbackBaseUrl . $callbackPath;

        $payload = [
            'BusinessShortCode' => $this->shortcode,
            'Password' => $password,
            'Timestamp' => $timestamp,
            'TransactionType' => 'CustomerPayBillOnline',
            'Amount' => $amount,
            'PartyA' => $this->normalizeMsisdn($phoneNumber),
            'PartyB' => $this->shortcode,
            'PhoneNumber' => $this->normalizeMsisdn($phoneNumber),
            'CallBackURL' => $callbackUrl,
            'AccountReference' => substr($accountReference, 0, 12),
            'TransactionDesc' => substr($transactionDesc, 0, 50)
        ];

        $url = $this->baseUrl() . '/mpesa/stkpush/v1/processrequest';
        $ch = curl_init($url);
        curl_setopt($ch, CURLOPT_HTTPHEADER, [
            'Content-Type: application/json',
            'Authorization: Bearer ' . $accessToken
        ]);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_POST, true);
        curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($payload));
        $response = curl_exec($ch);
        $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
        $err = curl_error($ch);
        curl_close($ch);

        if ($err || $httpCode >= 400) {
            return ['success' => false, 'message' => 'STK Push request failed', 'error' => $err, 'status' => $httpCode, 'response' => $response];
        }
        $data = json_decode($response, true) ?: [];
        // Success ResponseCode is usually "0"
        $ok = isset($data['ResponseCode']) && (string)$data['ResponseCode'] === '0';
        return ['success' => $ok, 'data' => $data, 'raw' => $response];
    }

    public function normalizeMsisdn(string $phone): string {
        // Remove non-digits
        $digits = preg_replace('/\D+/', '', $phone);
        if (strpos($digits, '0') === 0 && strlen($digits) === 10) {
            // 07XXXXXXXX -> 2547XXXXXXXX
            return '254' . substr($digits, 1);
        }
        if (strpos($digits, '254') === 0) {
            return $digits;
        }
        if (strpos($digits, '7') === 0 && strlen($digits) === 9) {
            return '254' . $digits;
        }
        // Best effort fallback
        return $digits;
    }
}
?>


