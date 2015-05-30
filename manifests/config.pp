# Internal: Manages the elasticsearch configuration files
#

class elasticsearch::config(
  $ensure            = $elasticsearch::params::ensure,
  $cluster           = $elasticsearch::params::cluster,
  $user              = $elasticsearch::params::user,
  $configdir         = $elasticsearch::params::configdir,
  $datadir           = $elasticsearch::params::datadir,
  $executable        = $elasticsearch::params::executable,
  $logdir            = $elasticsearch::params::logdir,
  $host              = $elasticsearch::params::host,
  $http_port         = $elasticsearch::params::http_port,
  $http_cors_enabled = $elasticsearch::params::http_cors_enabled,
  $transport_port    = $elasticsearch::params::transport_port,
) inherits elasticsearch::params {

  $dir_ensure = $ensure ? {
    present => directory,
    default => absent,
  }

  File {
    ensure => $ensure,
    owner  => $user
  }

  file {
    [
      $configdir,
      $datadir,
      $logdir
    ]:
      ensure => $dir_ensure ;

    "${configdir}/elasticsearch.yml":
      content => template('elasticsearch/elasticsearch.yml.erb') ;

    '/Library/LaunchDaemons/dev.elasticsearch.plist':
      content => template('elasticsearch/dev.elasticsearch.plist.erb'),
      group   => 'wheel',
      owner   => 'root' ;
  }

  if $::operatingsystem == 'Darwin' {
    boxen::env_script { 'elasticsearch':
      ensure   => $ensure,
      content  => template('elasticsearch/env.sh.erb'),
      priority => 'lower',
    }

    include boxen::config

    file { "${boxen::config::envdir}/elasticsearch.sh":
      ensure => absent,
    }
  }
}
