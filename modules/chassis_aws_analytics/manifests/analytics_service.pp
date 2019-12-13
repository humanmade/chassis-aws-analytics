define chassis_aws_analytics::analytics_service (
	$service = $name,
	$status = running,
	$active = true
) {
	# Install.
	exec { "${service} install":
		command => '/usr/bin/yarn --production',
		cwd     => "/vagrant/extensions/chassis_aws_analytics/local-${service}",
		user    => 'vagrant',
		unless  => "/usr/bin/test -d /vagrant/extensions/chassis_aws_analytics/local-${service}/node_modules",
		require => [
			Package['nodejs'],
			Exec['install yarn'],
		],
	}

	# Enable the service.
	exec { "systemctl enable ${service}":
		command     => "/bin/systemctl enable ${service}",
		refreshonly => true,
	}

	# Create service file.
	file { "/lib/systemd/system/${service}.service":
		ensure  => file,
		mode    => '0644',
		content => template("chassis_aws_analytics/${service}.service"),
		notify  => [
			Exec["systemctl enable ${service}"],
			Exec['systemctl-daemon-reload'],
		],
	}

	# Run the service.
	service { $service:
		ensure    => $status,
		enable    => $active,
		restart   => $active,
		hasstatus => $active,
		require   => Exec["${service} install"],
		subscribe => File["/lib/systemd/system/${service}.service"],
	}
}
