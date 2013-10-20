class elasticsearch::service(
  $ensure = $elasticsearch::params::ensure,
) inherits elasticsearch::params {

  $service_ensure = $ensure ? {
    present => running,
    default => stopped,
  }

  service { 'com.boxen.elasticsearch':
    ensure => false,
  }

  ->
  service { 'dev.elasticsearch':
    ensure  => $service_ensure,
  }

}
