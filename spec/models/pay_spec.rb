require 'spec_helper'

describe Pay do
  it 'emits human-readable values' do
    Pay.new(rate: 100, rate_interval: 'day').to_s.should == '$ 100 per day'
  end

  it 'emits nothing for human-readable value when blank' do
    Pay.new(rate: nil, rate_interval: 'day').to_s.should == nil 
  end

  it 'knows when it is blank' do
    Pay.new(rate: nil, rate_interval: 'day').should be_blank
  end
end
