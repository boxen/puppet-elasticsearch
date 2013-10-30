require 'spec_helper'

describe 'elasticsearch::config' do
  let(:facts) { default_test_facts }

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
