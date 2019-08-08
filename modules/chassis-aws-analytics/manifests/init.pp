class chassis-aws-analytics (
	$config
) {

	# Allow disabling the extension
	if ( !empty($config[disabled_extensions]) and 'humanmade/chassis-aws-analytics' in $config[disabled_extensions] ) {
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
