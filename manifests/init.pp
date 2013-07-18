# Public: Install and configure elasticsearch from homebrew.
#
# Examples
#
#   include elasticsearch
class elasticsearch {
  require elasticsearch::config
  include java
  require homebrew

  file { [
    $elasticsearch::config::configdir,
    $elasticsearch::config::datadir,
    $elasticsearch::config::logdir
  ]:
    ensure => directory,
  }

  file { $elasticsearch::config::configfile:
    content => template('elasticsearch/elasticsearch.yml.erb'),
    require => File[$elasticsearch::config::configdir],
    notify  => Service['dev.elasticsearch'],
  }

  file { '/Library/LaunchDaemons/dev.elasticsearch.plist':
    content => template('elasticsearch/dev.elasticsearch.plist.erb'),
    group   => 'wheel',
    notify  => Service['dev.elasticsearch'],
    owner   => 'root'
  }

  homebrew::formula { 'elasticsearch':
    before => Package['boxen/brews/elasticsearch'],
  }

  package { 'boxen/brews/elasticsearch':
    ensure  => '0.90.2-boxen1',
    notify  => Service['dev.elasticsearch'],
    require => Class['java'],
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
