# Internal: Manages the elasticsearch package
#
class elasticsearch::package(
  $ensure  = undef,
  $version = undef,
  $package = undef,
) {

  $package_ensure = $ensure ? {
    present => $version,
    default => installed,
  }

  if $::operatingsystem == 'Darwin' {
    homebrew::formula { 'elasticsearch': }
  }

  package { $package:
    ensure  => $package_ensure,
  }

}
