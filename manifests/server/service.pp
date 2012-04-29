class mcollective::server::service(

  $mc_service_name     = $mcollective::server::mc_service_name,
  $yaml_facter_source  = $mcollective::server::yaml_facter_source

) {
    anchor { 'mcollective::server::package::begin': }
    anchor { 'mcollective::server::package::end': }
    Class {
      require => Anchor['mcollective::server::package::begin'],
      before  => Anchor['mcollective::server::package::end'],
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
