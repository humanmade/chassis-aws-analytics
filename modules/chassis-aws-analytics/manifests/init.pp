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

	# Endpoints store.
	file { '/tmp/endpoints':
		ensure => directory,
		owner => 'www-data',
		mode => '0755',
	}

	$services = [ 'cognito', 'pinpoint' ]

	# Create services.
	analytics_service { $services:
		status => $status,
		active => $active,
	}

}
