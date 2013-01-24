require 'spec_helper'

describe 'elasticsearch::config' do
  let(:boxen_home) { '/opt/boxen' }
  let(:configdir) { "#{boxen_home}/config/elasticsearch" }
  let(:facts) do
    {
      :boxen_home => boxen_home,
      :boxen_user => 'testuser',
    }
  end

  it do
    should include_class('boxen::config')
  end
end
