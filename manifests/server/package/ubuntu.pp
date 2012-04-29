# This class installs MCollective dependency packages for Ubuntu.
class mcollective::server::package::ubuntu {
    case $lsbdistrelease {
      11.04, 10.10, 10.04: { # These distros dont have a new libstomp version, so we get it from the gem
		  package { 'libstomp':
		    ensure => present,
			provider => 'gem'
		  }->
		  package { 'mcollective':
		    ensure  => $mcollective::server::package_version,
		  }
    	
      }
	  default: {
		  package { 'libstomp-ruby':
		    ensure => present,
		  }->
		  package { 'mcollective':
		    ensure  => $mcollective::server::package_version,
		  }
	  }
    }
  

}

