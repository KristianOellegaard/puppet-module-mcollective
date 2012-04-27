class mcollective::server::service(

  $mc_service_name     = $mcollective::server::mc_service_name,
  $yaml_facter_source  = $mcollective::server::yaml_facter_source

) {
	
    case $operatingsystem {
      ubuntu: {
	  	service { 'mcollective':
	  		ensure    => running,
	  		enable    => true,
	  		name      => $mc_service_name,
	  		hasstatus => true,
			provider => 'upstart', # Do not use init.d for ubuntu.
	  	}
      }
      default: {
	  	service { 'mcollective':
	  		ensure    => running,
	  		enable    => true,
	  		name      => $mc_service_name,
	  		hasstatus => true,
	  	}
      }
    }
	
	cron { "facter_cache":
		command => "/usr/bin/facter -y -p > ${yaml_facter_source}.tmp ; mv -f ${yaml_facter_source}.tmp ${yaml_facter_source}",
		minute => "*/15",
	}
}
