# Internal: Configure elasticsearch.
#
# Examples
#
#   include elasticsearch::config
class elasticsearch::config {
  require boxen::config

  $cluster    = "elasticsearch_boxen_${::boxen_user}"
  $configdir  = "${boxen::config::configdir}/elasticsearch"
  $configfile = "${configdir}/elasticsearch.yml"
  $datadir    = "${boxen::config::datadir}/elasticsearch"
  $executable = "${boxen::config::homebrewdir}/bin/elasticsearch"
  $logdir     = "${boxen::config::logdir}/elasticsearch"
  $logfile    = "${logdir}/console.log"
  $port       = 19200
  $transport  = 19300
}
