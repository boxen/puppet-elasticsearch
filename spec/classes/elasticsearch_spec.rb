require 'spec_helper'

describe 'elasticsearch' do
  let(:facts) { default_test_facts }

  it do
    should include_class("elasticsearch::config")
    should include_class("elasticsearch::package")
    should include_class("elasticsearch::service")

    should include_class("java")
  end
end
