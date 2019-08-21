class chassis_aws_analytics (
	$config
) {

	# Allow disabling the extension
	if ( !empty($config[disabled_extensions]) and 'humanmade/chassis_aws_analytics' in $config[disabled_extensions] ) {
		$status = stopped
		$active = false
	} else {
		$status = running
		$active = true
	}

	# Create services.
	analytics_service { [ 'cognito', 'pinpoint' ]:
		status => $status,
		active => $active,
	}

}
