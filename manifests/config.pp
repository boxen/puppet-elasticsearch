class elasticsearch::config {
  require github::config

  $cluster    = "elasticsearch_github_${::luser}"
  $configdir  = "${github::config::configdir}/elasticsearch"
  $configfile = "${configdir}/elasticsearch.yml"
  $datadir    = "${github::config::datadir}/elasticsearch"
  $executable = "${github::config::homebrewdir}/bin/elasticsearch"
  $logdir     = "${github::config::logdir}/elasticsearch"
  $logfile    = "${logdir}/console.log"
  $port       = 19200
  $transport  = 19300

  file { [$configdir, $datadir, $logdir]:
    ensure => directory
  }

  file { $configfile:
    content => template('elasticsearch/elasticsearch.yml.erb'),
    require => File[$configdir],
    notify  => Service['com.github.elasticsearch'],
  }

  file { '/Library/LaunchDaemons/com.github.elasticsearch.plist':
    content => template('elasticsearch/com.github.elasticsearch.plist.erb'),
    group   => 'wheel',
    notify  => Service['com.github.elasticsearch'],
    owner   => 'root'
  }
}
