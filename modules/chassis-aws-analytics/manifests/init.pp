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

	# Create a service resource.
	define analytics_service (
		$status = running,
		$active = true
	) {
		# Install.
		exec { "${name} install":
			command => '/usr/bin/npm install --production',
			cwd     => "/vagrant/extensions/chassis-aws-analytics/local-${name}",
			user    => 'vagrant',
			unless  => "/usr/bin/test -d /vagrant/extensions/chassis-aws-analytics/local-${name}/node_modules",
			require => [
				Package['nodejs'],
			],
		}

		# Enable the service.
		exec { "systemctl enable ${name}":
			command     => "/bin/systemctl enable ${name}",
			refreshonly => true,
		}

		# Create service file.
		file { "/lib/systemd/system/${name}.service":
			ensure  => file,
			mode    => '0644',
			content => template("chassis-aws-analytics/${name}.service"),
			notify  => [
				Exec["systemctl enable ${name}"],
				Exec['systemctl-daemon-reload'],
			],
		}

		# Run the service.
		service { $name:
			ensure    => $status,
			enable    => $active,
			restart   => $active,
			hasstatus => $active,
			require   => Exec["${name} install"],
			subscribe => File["/lib/systemd/system/${name}.service"],
		}
	}

	$services = [ 'cognito', 'pinpoint' ]

	# Create services.
	analytics_service { $services:
		status => $status,
		active => $active,
	}

}
