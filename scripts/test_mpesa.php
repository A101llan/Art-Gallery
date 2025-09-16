<?php
// scripts/test_mpesa.php - Quick CLI test for Daraja OAuth and optional STK

require_once __DIR__ . '/../env.php';
require_once __DIR__ . '/../app/utils/MpesaDaraja.php';

function out($label, $value) {
    if (is_array($value) || is_object($value)) {
        echo $label . ": " . json_encode($value, JSON_PRETTY_PRINT) . "\n";
    } else {
        echo $label . ": " . $value . "\n";
    }
}

try {
    $daraja = new MpesaDaraja();
    out('ENV', getenv('MPESA_ENV'));
    out('SHORTCODE', getenv('MPESA_SHORTCODE'));
    out('CALLBACK_BASE', getenv('MPESA_CALLBACK_BASE_URL'));

    $token = $daraja->getAccessToken();
    out('OAuth', $token);

    if (!$token['success']) {
        exit(1);
    }

    // Optional STK test if phone provided as first arg
    $phone = $argv[1] ?? '';
    if ($phone) {
        $amount = (int)($argv[2] ?? 1);
        $resp = $daraja->stkPush($amount, $phone, 'TESTACC', 'CLI Test Purchase');
        out('STK', $resp);
    }
} catch (Throwable $e) {
    out('ERROR', $e->getMessage());
    exit(1);
}
?>


