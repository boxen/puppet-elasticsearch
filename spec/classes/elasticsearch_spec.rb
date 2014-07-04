require 'spec_helper'

describe 'elasticsearch' do
  let(:facts) { default_test_facts }

  it do
    should contain_class("elasticsearch::config")
    should contain_class("elasticsearch::package")
    should contain_class("elasticsearch::service")

    should contain_class("java")
  end
end
