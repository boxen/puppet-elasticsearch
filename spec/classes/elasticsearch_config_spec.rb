require 'spec_helper'

describe 'elasticsearch::config' do
  let(:facts) { default_test_facts }
  let(:params) { {
    "ensure"         => "present",
    "cluster"        => "foo",
    "user"           => "boxen",
    "configdir"      => "/test/boxen/config/elasticsearch",
    "datadir"        => "/test/boxen/data/elasticsearch",
    "executable"     => "/test/boxen/homebrew/bin/elasticsearch",
    "logdir"         => "/test/boxen/log/elasticsearch",
    "host"           => "127.0.0.1",
    "http_port"      => "8080",
    "transport_port" => "8081",
  } }

  it do
    %w(log config data).each do |d|
      should contain_file("/test/boxen/#{d}/elasticsearch").with_ensure(:directory)
    end

    should contain_file("/test/boxen/config/elasticsearch/elasticsearch.yml")

    should contain_file("/Library/LaunchDaemons/dev.elasticsearch.plist").with({
      :group => "wheel",
      :owner => "root",
    })

    should contain_boxen__env_script("elasticsearch").with({
      :ensure   => :present,
      :priority => "lower",
    })

    should contain_file("/test/boxen/env.d/elasticsearch.sh").with_ensure(:absent)
  end
end
