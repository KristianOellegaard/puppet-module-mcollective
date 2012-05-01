# This class manage the MCollective service for FreeBSD.
class mcollective::server::service::freebsd {
  	service { 'mcollective':
  		ensure    => running,
  		enable    => true,
  		name      => $mc_service_name,
  		hasstatus => true,
  	}
}

