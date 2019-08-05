<?php
/**
 * Local AWS Analytics.
 */

$scheme = $_SERVER['HTTPS'] === 'on' ? 'https' : 'http';

define( 'ALTIS_ANALYTICS_ELASTICSEARCH_URL', 'http://127.0.0.1:9200' );

define( 'ALTIS_ANALYTICS_PINPOINT_ID', '1234567890' );
define( 'ALTIS_ANALYTICS_PINPOINT_REGION', 'us-east-1' );
define( 'ALTIS_ANALYTICS_COGNITO_ID', '12345678901234567890abc' );
define( 'ALTIS_ANALYTICS_COGNITO_REGION', 'us-east-1' );

define( 'ALTIS_ANALYTICS_PINPOINT_ENDPOINT', $scheme . '://' . $_SERVER['HTTP_HOST'] . ':33671' );
define( 'ALTIS_ANALYTICS_COGNITO_ENDPOINT', $scheme . '://' . $_SERVER['HTTP_HOST'] . ':33670' );
