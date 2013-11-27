# Public: Install and configure elasticsearch from homebrew.
#
# Examples
#
#   include elasticsearch
class elasticsearch(
  $ensure         = $elasticsearch::params::ensure,

  $version        = $elasticsearch::params::version,
  $package        = $elasticsearch::params::package,

  $cluster        = $elasticsearch::params::cluster,
  $user           = $elasticsearch::params::user,
  $configdir      = $elasticsearch::params::configdir,
  $datadir        = $elasticsearch::params::datadir,
  $executable     = $elasticsearch::params::executable,
  $logdir         = $elasticsearch::params::logdir,
  $host           = $elasticsearch::params::host,
  $http_port      = $elasticsearch::params::http_port,
  $transport_port = $elasticsearch::params::transport_port,

  $enable         = $elasticsearch::params::enable,
) inherits elasticsearch::params {

  include java

  class { 'elasticsearch::package':
    ensure  => $ensure,

    version => $version,
    package => $package,
  }

  ~>
  class { 'elasticsearch::config':
    ensure         => $ensure,

    cluster        => $cluster,
    user           => $user,
    configdir      => $configdir,
    datadir        => $datadir,
    executable     => $executable,
    logdir         => $logdir,
    host           => $host,
    http_port      => $http_port,
    transport_port => $transport_port,

    notify         => Service['elasticsearch'],
  }

  ~>
  class { 'elasticsearch::service':
    ensure => $ensure,

    enable => $enable,
  }

}
