class chassis-aws-analytics (
	$config
) {

	# Install Docker
	include 'docker'

	# Install Docker Compose
	class { 'docker::compose':
		ensure => present,
	}

	if ( ! empty( $config[disabled_extensions] ) and 'humanmade/chassis-aws-analytics' in $config[disabled_extensions] ) {
		$dir = absent
		$compose_file = absent
	} else {
		$dir = directory
		$compose_file = present
	}

	# Add the docker-compose.yaml file.
	file { '/home/vagrant/aws-analytics':
		ensure => $dir,
	}
	file { '/home/vagrant/aws-analytics/docker-compose.yaml':
		ensure  => $compose_file,
		mode    => '0777',
		content => template('chassis-aws-analytics/docker-compose.yaml'),
		require => [
			File['/home/vagrant/aws-analytics'],
		],
	}

	# Start the stack.
	docker_compose { '/home/vagrant/aws-analytics/docker-compose.yaml':
		ensure  => $compose_file,
		require => [
			Class['docker::compose'],
			File['/home/vagrant/aws-analytics/docker-compose.yaml'],
		],
	}

}
