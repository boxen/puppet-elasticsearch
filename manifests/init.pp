class elasticsearch {
  require elasticsearch::config
  require java

  package { 'github/brews/elasticsearch':
    ensure => '0.19.9-github1',
    notify => Service['com.github.elasticsearch']
  }

  service { 'com.github.elasticsearch':
    ensure  => running,
    require => Package['github/brews/elasticsearch']
  }


  file { "${github::config::envdir}/elasticsearch.sh":
    content => template('elasticsearch/env.sh.erb'),
    require => File[$github::config::envdir]
  }
}
