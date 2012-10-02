class elasticsearch {
  require elasticsearch::config
  require java

  package { 'boxen/brews/elasticsearch':
    ensure => '0.19.9-boxen1',
    notify => Service['com.boxen.elasticsearch']
  }

  service { 'com.boxen.elasticsearch':
    ensure  => running,
    require => Package['boxen/brews/elasticsearch']
  }


  file { "${boxen::config::envdir}/elasticsearch.sh":
    content => template('elasticsearch/env.sh.erb'),
    require => File[$boxen::config::envdir]
  }
}
