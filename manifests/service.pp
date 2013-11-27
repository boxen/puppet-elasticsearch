# Internal: Manages the elasticsearch service
#
class elasticsearch::service(
  $ensure = $elasticsearch::params::ensure,
  $enable = $elasticsearch::params::enable,
) inherits elasticsearch::params {

  $service_ensure = $ensure ? {
    present => running,
    default => stopped,
  }

  service { 'com.boxen.elasticsearch':
    ensure => stopped,
    enable => false,
  }

  ->
  service { 'dev.elasticsearch':
    ensure => $service_ensure,
    enable => $enable,
    alias  => 'elasticsearch',
  }

}
