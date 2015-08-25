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
end
