# This class manage the MCollective service for Ubuntu.
class mcollective::server::service::ubuntu {
    case $lsbdistrelease {
      11.04, 10.10, 10.04: {
    	service { 'mcollective':
    		ensure    => running,
    		enable    => true,
    		name      => $mc_service_name,
    		hasstatus => true,
    	}
      }
	  default: {
	    	service { 'mcollective':
	    		ensure    => running,
	    		enable    => true,
	    		name      => $mc_service_name,
	    		hasstatus => true,
	  			provider => 'upstart', # Do not use init.d for newer ubuntu releases.
	    	}
	  }
    }
}

