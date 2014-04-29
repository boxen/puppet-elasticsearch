# Public: Install and configure elasticsearch from homebrew.
#
# Examples
#
#   include elasticsearch
class elasticsearch(
  $ensure         = undef,

  $version        = undef,
  $package        = undef,

  $cluster        = undef,
  $user           = undef,
  $configdir      = undef,
  $datadir        = undef,
  $executable     = undef,
  $logdir         = undef,
  $host           = undef,
  $http_port      = undef,
  $transport_port = undef,

  $enable         = undef,
) {
  validate_string(
    $version,
    $package,
    $cluster,
    $user,
    $configdir,
    $datadir,
    $logdir,
    $host,
  )

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
