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

  it 'filters by position through competency' do
    jen = FactoryGirl.create(:employee, last_name: 'Abacus')
    john = FactoryGirl.create(:employee, last_name: 'Bowling')
    jane = FactoryGirl.create(:employee, last_name: 'Fowler')
    ginesh = FactoryGirl.create(:employee, last_name: 'Ginesh')

    working_girl = FactoryGirl.create(:position)

    FactoryGirl.create(:competency, employee: jen, position: working_girl, rating: "C")
    FactoryGirl.create(:competency, employee: john, position: working_girl, rating: "A")
    FactoryGirl.create(:competency, employee: jane, position: working_girl, rating: "B")

    results = EmployeeSearch.new(position_id: working_girl.id).results
    results.should include(jen)
    results.should include(jane)
    results.should include(john)
    results.should_not include(ginesh)
  end

  it 'filters by availability' do
    dentist = FactoryGirl.create(:position)
    jen = FactoryGirl.create(:employee)
    FactoryGirl.create(:competency, employee: jen, position: dentist)
    FactoryGirl.create(:assignment, employee: jen, position: dentist)
    john = FactoryGirl.create(:employee)

    results = EmployeeSearch.new(include_assigned: 'false').results
    results.should_not include(jen)
    results.should include(john)
  end

  it 'filters by status' do
    jen = FactoryGirl.create(:employee, status: 'Prospect')
    EmployeeSearch.new(status: 'Active').results.should_not include(jen)
  end

  it 'sorts by term date' do
    melvin = FactoryGirl.create(:employee, last_worked_on: 5.days.ago, status: 'Terminated')
    leo = FactoryGirl.create(:employee, last_worked_on: 3.days.ago, status: 'Terminated')
    ovelia = FactoryGirl.create(:employee, last_worked_on: 15.days.ago, status: 'Terminated')

    EmployeeSearch.new(status: 'Terminated', sort: 'last_worked_on desc').results.map(&:id).should eq [leo, melvin, ovelia].map(&:id)
  end

  it 'defaults to sorting by last name' do
    EmployeeSearch.new.sort.should eq "last_name asc"
  end
end
