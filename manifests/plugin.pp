# Manage the files for MCollective plugins.
#
# == Parameters
#
# === General Parameters
#
# [*type*]
#   *Mandatory* The type of plugin.
# [*ensure*]
#   *Optional* If true then it installs, if false it will be uninstalled. Default value is true
# [*ddl*]
#   *Optional* Is there a DDL for this type?
# [*application*]
#   *Optional* Is there an application for this plugin?
#
# === Advanced Tunables
#
# [*plugin_base*]
#   *Optional* The base location for plugins.
# [*module_source*]
#   *Optional* The URI source for obtain plugins.
#
# == Example
#
#     mcollective::plugin { 'package':
#       ensure      => present,
#       type        => 'agent',
#       ddl         => true,
#       application => false,
#     }
#
define mcollective::plugin(
  $type,
  $ensure      = present,
  $ddl         = false,
  $application = false,
  $plugin_base = $mcollective::params::plugin_base,
  $module_source = 'puppet:///modules/mcollective/plugins'
) {

  include mcollective::params

  File {
    owner => '0',
    group => '0',
    mode  => '0644',
  }

  if $plugin_base == '' {
    $plugin_base_real = $mcollective::params::plugin_base
  } else {
    $plugin_base_real = $plugin_base
  }

  if ($ddl == true or $application == true) and $type != 'agent' {
    fail('DDLs and Applications only apply to Agent plugins')
  }

  file { "${plugin_base_real}/${type}/${name}.rb":
    ensure => $ensure,
    source => "${module_source}/${type}/${name}.rb",
    notify => Class['mcollective::server::service'],
  }

  if $ddl {
    file { "${plugin_base_real}/${type}/${name}.ddl":
      ensure => $ensure,
      source => "${module_source}/${type}/${name}.ddl",
    }
  }

  if $application {
    file { "${plugin_base_real}/application/${name}.rb":
      ensure => $ensure,
      source => "${module_source}/application/${name}.rb",
    }
  }

}
