require "spec_helper"

describe "elasticsearch::service" do
  let(:facts) { default_test_facts }
  let(:params) { {
    :ensure => 'present',
    :enable => true
  } }

  it do
    should contain_service("com.boxen.elasticsearch").with_ensure(:stopped)
    should contain_service("dev.elasticsearch").with({
      :ensure => :running,
      :enable => true,
      :alias  => 'elasticsearch'
    })
  end
end
