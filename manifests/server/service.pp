class mcollective::server::service(

  $mc_service_name     = $mcollective::server::mc_service_name,
  $yaml_facter_source  = $mcollective::server::yaml_facter_source

) {
    anchor { 'mcollective::server::service::begin': }
    anchor { 'mcollective::server::service::end': }
    Class {
      require => Anchor['mcollective::server::service::begin'],
      before  => Anchor['mcollective::server::service::end'],
    }

    case $operatingsystem {
      debian: {
        class { 'mcollective::server::service::debian': }
      }
	  ubuntu: {
	  	class { 'mcollective::server::service::ubuntu': }
	  }
      redhat,centos,oel: {
        class { 'mcollective::server::service::redhat': }
      }
      default: {
        fail("operatingsystem not supported: ${operatingsystem}")
      }
    }
	
	cron { "facter_cache":
		command => "/usr/bin/facter -y -p > ${yaml_facter_source}.tmp ; mv -f ${yaml_facter_source}.tmp ${yaml_facter_source}",
		minute => "*/15",
	}
}
