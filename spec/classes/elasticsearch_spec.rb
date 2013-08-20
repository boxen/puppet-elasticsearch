require 'spec_helper'

describe 'elasticsearch' do
  let(:boxen_home) { '/opt/boxen' }
  let(:configdir) { "#{boxen_home}/config/elasticsearch" }
  let(:facts) do
    {
      :boxen_home => boxen_home,
      :boxen_user => 'testuser',
    }
  end

  it do
    should include_class('elasticsearch::config')
    should include_class('homebrew')
    should include_class('java')

    should contain_homebrew__formula('elasticsearch').
      with_before('Package[boxen/brews/elasticsearch]')

    ['config', 'data', 'log'].each do |dir|
      should contain_file("#{boxen_home}/#{dir}/elasticsearch").with({
        :ensure => 'directory',
      })
    end

    should contain_file("#{configdir}/elasticsearch.yml").with({
      #:content => File.read('spec/fixtures/elasticsearch.yml'),
      :require => "File[#{configdir}]",
      :notify  => 'Service[dev.elasticsearch]',
    })

    should contain_file('/Library/LaunchDaemons/dev.elasticsearch.plist').with({
      :content => File.read('spec/fixtures/dev.elasticsearch.plist'),
      :group   => 'wheel',
      :notify  => 'Service[dev.elasticsearch]',
      :owner   => 'root',
    })

    should contain_package('boxen/brews/elasticsearch').with({
      :ensure => '0.90.2-boxen1',
      :notify => 'Service[dev.elasticsearch]',
    })

    should contain_service('dev.elasticsearch').with({
      :ensure  => 'running',
      :require => 'Package[boxen/brews/elasticsearch]',
    })

    should contain_file('/opt/boxen/env.d/elasticsearch.sh').with({
      :content => File.read('spec/fixtures/elasticsearch.sh'),
      :require => 'File[/opt/boxen/env.d]',
    })
  end
end
