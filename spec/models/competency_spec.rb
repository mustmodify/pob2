require 'spec_helper'

describe Competency do
  it 'requires interval' do
    FactoryGirl.build(:competency, rate: 100, rate_interval: nil).should_not be_valid
  end
end
