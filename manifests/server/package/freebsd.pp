# This class installs MCollective dependency packages for FreeBSD.
class mcollective::server::package::freebsd {
	
  package { 'sysutils/mcollective':
    ensure  => $mcollective::server::package_version,
  }
  

}

