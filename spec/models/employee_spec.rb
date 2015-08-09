require 'spec_helper'

describe Employee do
  it 'is valid given valid attributes' do
    FactoryGirl.build(:employee).should be_valid
  end

  it 'requires first name' do
    FactoryGirl.build(:employee, first_name: nil).should_not be_valid
  end

  it 'requires last name' do
    FactoryGirl.build(:employee, last_name: nil).should_not be_valid
  end
end
