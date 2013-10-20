# Public: Install and configure elasticsearch from homebrew.
#
# Examples
#
#   include elasticsearch
class elasticsearch(
  $ensure  = $elasticsearch::params::ensure,
  $version = $elasticsearch::params::version,
  $package = $elasticsearch::params::package,
) inherits elasticsearch::params {

  include java

  class { 'elasticsearch::config':
    ensure => $ensure,
  }

  ~>
  class { 'elasticsearch::package':
    ensure  => $ensure,
    version => $version,
    package => $package,
  }

  ~>
  class { 'elasticsearch::service':
    ensure => $ensure,
  }

}
