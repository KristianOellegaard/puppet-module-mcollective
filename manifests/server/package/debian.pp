# This class installs MCollective dependency packages for Debian.
class mcollective::server::package::debian {

  package { 'libstomp-ruby':
    ensure => present,
  }->
  package { 'mcollective':
    ensure  => $mcollective::server::package_version,
  }->
  file { 'Debian init script fix': # TODO: Make this parameterized
	path => '/etc/init.d/mcollective'
	source => 'puppet:///debian/etc/init.d/mcollective',
  }
  

}

