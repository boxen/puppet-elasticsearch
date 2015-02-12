# Internal: Configure elasticsearch.

class elasticsearch::params {

  case $::osfamily {
    Darwin: {
      include boxen::config

      $ensure         = 'present'

      $version        = '1.4.2-boxen1'
      $package        = 'boxen/brews/elasticsearch'

      $cluster        = "elasticsearch_boxen_${::boxen_user}"
      $user           = $::boxen_user
      $configdir      = "${boxen::config::configdir}/elasticsearch"
      $datadir        = "${boxen::config::datadir}/elasticsearch"
      $executable     = "${boxen::config::homebrewdir}/bin/elasticsearch"
      $logdir         = "${boxen::config::logdir}/elasticsearch"

      $host           = '127.0.0.1'
      $http_port      = 19200
      $transport_port = 19300

      $enable         = true
    }

    default: {
      fail("Unsupported operating system: ${::osfamily}")
    }
  }

}
