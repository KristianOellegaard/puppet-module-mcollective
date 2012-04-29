# This class manage the MCollective service for Debian.
class mcollective::server::service::debian {
  	service { 'mcollective':
  		ensure    => running,
  		enable    => true,
  		name      => $mc_service_name,
  		hasstatus => true,
  	}
}

