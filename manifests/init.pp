# Public: Install and configure elasticsearch from homebrew.
#
# Examples
#
#   include elasticsearch
class elasticsearch {
  require elasticsearch::config
  require java

  package { 'boxen/brews/elasticsearch':
    ensure => '0.19.9-boxen1',
    notify => Service['dev.elasticsearch']
  }

  service { 'dev.elasticsearch':
    ensure  => running,
    require => Package['boxen/brews/elasticsearch']
  }

  service { 'com.boxen.elasticsearch': # replaced by dev.elasticsearch
    before => Service['dev.elasticsearch'],
    enable => false
  }

  file { "${boxen::config::envdir}/elasticsearch.sh":
    content => template('elasticsearch/env.sh.erb'),
    require => File[$boxen::config::envdir]
  }
}
