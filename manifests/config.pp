class elasticsearch::config(
  $ensure         = $elasticsearch::params::ensure,
  $cluster        = $elasticsearch::params::cluster,
  $user           = $elasticsearch::params::user,
  $configdir      = $elasticsearch::params::configdir,
  $datadir        = $elasticsearch::params::datadir,
  $executable     = $elasticsearch::params::executable,
  $logdir         = $elasticsearch::params::logdir,
  $http_port      = $elasticsearch::params::http_port,
  $transport_port = $elasticsearch::params::transport_port,
) inherits elasticsearch::params {

  File {
    owner => $user
  }

  file {
    [
      $configdir,
      $datadir,
      $logdir
    ]:
      ensure => directory ;

    "${configdir}/elasticsearch.yml":
      content => template('elasticsearch/elasticsearch.yml.erb') ;

    '/Library/LaunchDaemons/dev.elasticsearch.plist':
      content => template('elasticsearch/dev.elasticsearch.plist.erb'),
      group   => 'wheel',
      owner   => 'root' ;

    "${envdir}/elasticsearch.sh":
      content => template('elasticsearch/env.sh.erb') ;
  }

}
