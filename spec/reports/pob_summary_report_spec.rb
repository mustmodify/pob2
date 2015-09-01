require 'spec_helper'

describe POBSummaryReport do
  it 'lists all dates during which an employee worked' do
    ed = FactoryGirl.create(:employee)
    fred = FactoryGirl.create(:project)

    start1 = Date.parse('2015-07-01')
    end1 = Date.parse('2015-07-10')

    start2 = Date.parse('2015-07-21')
    end2 = Date.parse('2015-07-24')

    FactoryGirl.create(:job, employee: ed, onboarding_date: start1, offboarding_date: end1, project: fred)
    FactoryGirl.create(:job, employee: ed, onboarding_date: start2, offboarding_date: end2, project: fred)

    data = POBSummaryReport.new.data
    data.should have(2).entry
    data.first.employee.should == ed
    data.first.start_date.should == start1
    data.first.end_date.should == end1
  end

  it 'filters by project' do
    ed = FactoryGirl.create(:employee)
    fred = FactoryGirl.create(:project)

    FactoryGirl.create(:job, employee: ed, onboarding_date: '2015-07-20', offboarding_date: '2015-07-26', project: fred)

    data = POBSummaryReport.new(project_id: fred.id + 1).data
    data.should have(0).entries
    data = POBSummaryReport.new(project_id: fred.id).data
    data.should have(1).entries
  end

  it 'excludes by start date' do
    ed = FactoryGirl.create(:employee)
    fred = FactoryGirl.create(:project)

    start1 = Date.parse('2015-07-01')
    end1 = Date.parse('2015-07-10')

    FactoryGirl.create(:job, employee: ed, onboarding_date: start1, offboarding_date: end1, project: fred)

    data = POBSummaryReport.new(start_date: '2015-07-20').data.should be_empty
  end

  it 'includes entries where POB overlaps the start date' do
    ed = FactoryGirl.create(:employee)
    rig = FactoryGirl.create(:project)

    start1 = Date.parse('2015-07-01')
    end1 = Date.parse('2015-07-10')

    FactoryGirl.create(:job, employee: ed, onboarding_date: start1, offboarding_date: end1)

    datum = POBSummaryReport.new(start_date: '2015-07-08').data.first
    datum.should_not be_blank
    datum.start_date.should == Date.parse('2015-07-08')
    datum.end_date.should == Date.parse('2015-07-10')
  end

  it 'excludes by end date' do
    ed = FactoryGirl.create(:employee)
    fred = FactoryGirl.create(:project)

    start1 = Date.parse('2015-07-01')
    end1 = Date.parse('2015-07-10')

    FactoryGirl.create(:job, employee: ed, onboarding_date: start1, offboarding_date: end1)
    data = POBSummaryReport.new(end_date: '2015-06-20').data.should be_empty
  end

  it 'correctly handles various overlapping issues' do
    ed = FactoryGirl.create(:employee)
    fred = FactoryGirl.create(:project)

    start1 = Date.parse('2015-07-01')
    end1 = Date.parse('2015-07-10')

    FactoryGirl.create(:job, employee: ed, onboarding_date: start1, offboarding_date: end1)
    data = POBSummaryReport.new(start_date: '2015-06-05', end_date: '2015-07-20').data.should have(1).item
    data = POBSummaryReport.new(start_date: '2015-07-05', end_date: '2015-07-07').data.should have(1).item
  end

  it 'correctly stops when an employees stay overlaps an end date' do
    ed = FactoryGirl.create(:employee)
    fred = FactoryGirl.create(:project)

    start1 = Date.parse('2015-07-01')
    end1 = Date.parse('2015-07-10')

    FactoryGirl.create(:job, employee: ed, onboarding_date: start1, offboarding_date: end1)

    datum = POBSummaryReport.new(end_date: '2015-07-03').data.first
    datum.start_date.should == Date.parse('2015-07-01')
    datum.end_date.should == Date.parse('2015-07-03')
    datum.offboarding_date.should == end1 
  end

  it 'filters by employee' do
    ed = FactoryGirl.create(:employee)
    ned = FactoryGirl.create(:employee)
    fred = FactoryGirl.create(:project)

    start1 = Date.parse('2015-07-01')
    end1 = Date.parse('2015-07-10')

    FactoryGirl.create(:job, employee: ed, onboarding_date: start1, offboarding_date: end1)

    POBSummaryReport.new(employee_id: ned.id).data.should be_empty
  end

  it 'shows no results if require_parameters is set and no OTHER parameters are set' do
    ed = FactoryGirl.create(:employee)
    ned = FactoryGirl.create(:employee)
    fred = FactoryGirl.create(:project)

    start1 = Date.parse('2015-07-01')
    end1 = Date.parse('2015-07-10')

    FactoryGirl.create(:job, employee: ed, onboarding_date: start1, offboarding_date: end1)

    POBSummaryReport.new(require_params: true).data.should be_empty
  end
end
