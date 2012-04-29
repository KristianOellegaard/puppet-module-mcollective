# This class manage the MCollective service for Redhat.
class mcollective::server::service::redhat {
  	service { 'mcollective':
  		ensure    => running,
  		enable    => true,
  		name      => $mc_service_name,
  		hasstatus => true,
  	}
}

