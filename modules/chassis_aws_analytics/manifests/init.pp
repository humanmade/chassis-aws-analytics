class chassis_aws_analytics (
	$config
) {

	# Allow disabling the extension
	if ( !empty($config[disabled_extensions]) and 'humanmade/chassis_aws_analytics' in $config[disabled_extensions] ) {
		$package = absent
		$status = stopped
		$active = false
	} else {
		$package = present
		$status = running
		$active = true
	}

	# Create services.
	analytics_service { [ 'cognito', 'pinpoint' ]:
		status => $status,
		active => $active,
	}

	# Configure nginx.
	file { "/etc/nginx/sites-available/${fqdn}.d/aws-analytics.nginx.conf":
		ensure  => $package,
		content => template('chassis_aws_analytics/nginx.conf.erb'),
		notify  => Service['nginx'],
		require => File["/etc/nginx/sites-available/${fqdn}.d"],
	}

}
