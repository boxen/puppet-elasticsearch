# Internal: Manages the elasticsearch service
#
class elasticsearch::service(
  $ensure = undef,
  $enable = undef,
) {

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
