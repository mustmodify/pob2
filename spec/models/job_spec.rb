require 'spec_helper'

describe Job do
  it 'is valid given valid attributes' do
    FactoryGirl.build(:job).should be_valid
  end

  it 'must have a project' do
    FactoryGirl.build(:job, project: nil).should_not be_valid
  end

  it 'emits pay when numbers are known' do
    Job.new(rate: 100, rate_interval: 'day').pay.should == Pay.new(rate: 100, rate_interval: 'day')
  end

  it 'skips pay when numbers are unknown' do
    Job.new(rate: nil, rate_interval: 'day').pay.should be_nil
  end
end
