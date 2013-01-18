require 'spec_helper'

describe 'elasticsearch::config' do
  let(:boxen_home) { '/opt/boxen' }
  let(:configdir) { "#{boxen_home}/config/elasticsearch" }
  let(:facts) do
    {
      :boxen_home => boxen_home,
      :luser      => 'testuser',
    }
  end

  it { should include_class('boxen::config') }

  ['config', 'data', 'log'].each do |dir|
    it do
      should contain_file("#{boxen_home}/#{dir}/elasticsearch").with({
        :ensure => 'directory',
      })
    end
  end

  it do
    should contain_file("#{configdir}/elasticsearch.yml").with({
      :content => File.read('spec/fixtures/elasticsearch.yml'),
      :require => "File[#{configdir}]",
      :notify  => 'Service[dev.elasticsearch]',
    })
  end

  it do
    should contain_file('/Library/LaunchDaemons/dev.elasticsearch.plist').with({
      :content => File.read('spec/fixtures/dev.elasticsearch.plist'),
      :group   => 'wheel',
      :notify  => 'Service[dev.elasticsearch]',
      :owner   => 'root',
    })
  end
end
