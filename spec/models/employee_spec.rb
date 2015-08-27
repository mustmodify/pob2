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

  it 'stores stripped-down phone numbers' do
    Employee.new(cell_phone: '(337) 326-3121').send(:read_attribute, :cell_phone).should == '3373263121'
  end

  it 'formats phone numbers' do
    Employee.new(cell_phone: '3373263121').cell_phone.to_s.should == '(337) 326-3121'
  end
end
