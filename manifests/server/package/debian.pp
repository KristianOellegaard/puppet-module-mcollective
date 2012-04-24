# This class installs MCollective dependency packages for Debian.
class mcollective::server::package::debian {

  package { 'libstomp-ruby':
    ensure => present,
  }->
  package { 'mcollective':
    ensure  => $mcollective::server::package_version,
  }->
  file { 'Debian init script fix': # TODO: Make this parameterized
	path => '/etc/init.d/mcollective',
	mode => 755,
	source => 'puppet:///modules/mcollective/debian/etc/init.d/mcollective',
  }->
  file_line { 'Debian upstart fix': # TODO: Make this parameterized
    path => '/etc/init/mcollective.conf',
    line => 'expect fork',
  }
  

}

