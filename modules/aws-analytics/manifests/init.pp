class aws-analytics (
	$config
) {

	# Install Docker
	include 'docker'

	# Stop services.
	if ( ! empty( $config[disabled_extensions] ) and 'humanmade/chassis-aws-analytics' in $config[disabled_extensions] ) {

	} else {

	}


	# Run Cognito
	docker::run {

	}

}
