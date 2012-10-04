# Internal: Configure elasticsearch.
#
# Examples
#
#   include elasticsearch::config
class elasticsearch::config {
  require boxen::config

  $cluster    = "elasticsearch_boxen_${::luser}"
  $configdir  = "${boxen::config::configdir}/elasticsearch"
  $configfile = "${configdir}/elasticsearch.yml"
  $datadir    = "${boxen::config::datadir}/elasticsearch"
  $executable = "${boxen::config::homebrewdir}/bin/elasticsearch"
  $logdir     = "${boxen::config::logdir}/elasticsearch"
  $logfile    = "${logdir}/console.log"
  $port       = 19200
  $transport  = 19300

  file { [$configdir, $datadir, $logdir]:
    ensure => directory
  }

  file { $configfile:
    content => template('elasticsearch/elasticsearch.yml.erb'),
    require => File[$configdir],
    notify  => Service['com.boxen.elasticsearch'],
  }

  file { '/Library/LaunchDaemons/com.boxen.elasticsearch.plist':
    content => template('elasticsearch/com.boxen.elasticsearch.plist.erb'),
    group   => 'wheel',
    notify  => Service['com.boxen.elasticsearch'],
    owner   => 'root'
  }
}
