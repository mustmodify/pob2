require 'spec_helper'

describe EmployeeSearch do
  it 'shows all employees with no attributes' do
    jen = FactoryGirl.create(:employee)
    EmployeeSearch.new.results.should include(jen)
  end

  it 'filters by certificate expiration date' do
    jen = FactoryGirl.create(:employee)
    FactoryGirl.create(:cert, :expires_on => 45.days.from_now, :employee => jen)
    EmployeeSearch.new(cert_expiration_period: 30.days.to_i).results.should_not include(jen)
    EmployeeSearch.new(cert_expiration_period: 60.days.to_i).results.should include(jen)
  end

  it 'does not duplicate employee who has two expiring certs' do
    jen = FactoryGirl.create(:employee)
    FactoryGirl.create(:cert, :expires_on => 15.days.from_now, :employee => jen)
    FactoryGirl.create(:cert, :expires_on => 25.days.from_now, :employee => jen)
    EmployeeSearch.new(cert_expiration_period: 30.days.to_i).results.length.should == 1
  end

  it 'filters by whether transport is required' do
    jen = FactoryGirl.create(:employee, transportation_needed: true)
    EmployeeSearch.new(include_those_needing_transport: false).results.should_not include(jen)
  end

  it 'accepts transportation message' do
    EmployeeSearch.new("include_those_needing_transport"=>"false").include_those_needing_transport.should == false
  end

  it 'filters by status' do
    jen = FactoryGirl.create(:employee, status: 'Prospect')
    EmployeeSearch.new(status: 'Active').results.should_not include(jen)
  end
end
