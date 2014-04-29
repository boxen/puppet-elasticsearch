require "spec_helper"

describe "elasticsearch::package" do
  let(:facts) { default_test_facts }
  let(:params) { {
    :ensure => "present",
    :version => "0.90.5-boxen1",
    :package => "boxen/brews/elasticsearch"
  } }

  it do
    should contain_homebrew__formula("elasticsearch")

    should contain_package("boxen/brews/elasticsearch").with_ensure("0.90.5-boxen1")
  end
end
