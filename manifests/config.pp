# Internal: Manages the elasticsearch configuration files
#

class elasticsearch::config(
  $ensure         = undef,
  $cluster        = undef,
  $user           = undef,
  $configdir      = undef,
  $datadir        = undef,
  $executable     = undef,
  $logdir         = undef,
  $host           = undef,
  $http_port      = undef,
  $transport_port = undef,
) {

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

    file { '/Library/LaunchDaemons/dev.elasticsearch.plist':
      content => template('elasticsearch/dev.elasticsearch.plist.erb'),
      group   => 'wheel',
      owner   => 'root'
    }
  }
}
