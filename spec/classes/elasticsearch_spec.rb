require 'spec_helper'

describe 'elasticsearch' do
  let(:facts) do
    {
      :boxen_home => '/opt/boxen',
    }
  end

  it { should include_class('elasticsearch::config') }
  it { should include_class('java') }

  it do
    should contain_package('boxen/brews/elasticsearch').with({
      :ensure => '0.19.9-boxen1',
      :notify => 'Service[dev.elasticsearch]',
    })
  end

  it do
    should contain_service('dev.elasticsearch').with({
      :ensure  => 'running',
      :require => 'Package[boxen/brews/elasticsearch]',
    })
  end

  it do
    should contain_file('/opt/boxen/env.d/elasticsearch.sh').with({
      :content => File.read('spec/fixtures/elasticsearch.sh'),
      :require => 'File[/opt/boxen/env.d]',
    })
  end
end
