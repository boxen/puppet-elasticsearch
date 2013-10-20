# Internal: Configure elasticsearch.

class elasticsearch::params {

  case $::osfamily {
    Darwin: {
      require boxen::config

      $ensure         = 'present'
      $version        = '0.90.5-boxen1'
      $package        = 'boxen/brews/elasticsearch'

      $cluster        = "elasticsearch_boxen_${::boxen_user}"

      $user           = $::boxen_user

      $configdir      = "${boxen::config::configdir}/elasticsearch"
      $datadir        = "${boxen::config::datadir}/elasticsearch"
      $executable     = "${boxen::config::homebrewdir}/bin/elasticsearch"
      $logdir         = "${boxen::config::logdir}/elasticsearch"
      $envdir         = $boxen::config::envdir

      $logfile        = "${logdir}/console.log"
      $http_port      = 19200
      $transport_port = 19300
    }

    default: {
      fail("Unsupported operating system: ${::osfamily}")
    }
  }

}
