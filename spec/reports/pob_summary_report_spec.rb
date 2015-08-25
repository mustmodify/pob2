require 'spec_helper'

describe POBSummaryReport do
  it 'lists all dates during which an employee worked' do
    ed = FactoryGirl.create(:employee)
    fred = FactoryGirl.create(:project)

    start1 = Date.parse('2015-07-01')
    end1 = Date.parse('2015-07-10')

    start2 = Date.parse('2015-07-21')
    end2 = Date.parse('2015-07-24')

    in1 = FactoryGirl.create(:crew_change, employee: ed, date: start1, action: 'In', project: fred)
    out1 = FactoryGirl.create(:crew_change, employee: ed, date: end1, action: 'Out', project: fred)

    in2 = FactoryGirl.create(:crew_change, employee: ed, date: start2, action: 'In', project: fred)
    out2 = FactoryGirl.create(:crew_change, employee: ed, date: end2, action: 'Out', project: fred)

    data = POBSummaryReport.new.data
    data.should have(2).entry
    data.first.employee.should == ed
    data.first.start_date.should == start1
    data.first.end_date.should == end1
  end

  it 'excludes by start date' do
    ed = FactoryGirl.create(:employee)
    fred = FactoryGirl.create(:project)

    start1 = Date.parse('2015-07-01')
    end1 = Date.parse('2015-07-10')

    in1 = FactoryGirl.create(:crew_change, employee: ed, date: start1, action: 'In', project: fred)
    out1 = FactoryGirl.create(:crew_change, employee: ed, date: end1, action: 'Out', project: fred)

    data = POBSummaryReport.new(start_date: '2015-07-20').data.should be_empty
  end

  it 'includes entries where POB overlaps the start date' do
    ed = FactoryGirl.create(:employee)
    rig = FactoryGirl.create(:project)

    start1 = Date.parse('2015-07-01')
    end1 = Date.parse('2015-07-10')

    in1 = FactoryGirl.create(:crew_change, employee: ed, date: start1, action: 'In', project: rig)
    out1 = FactoryGirl.create(:crew_change, employee: ed, date: end1, action: 'Out', project: rig)

    datum = POBSummaryReport.new(start_date: '2015-07-08').early_overlaps.should have(1).item
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

    in1 = FactoryGirl.create(:crew_change, employee: ed, date: start1, action: 'In', project: fred)
    out1 = FactoryGirl.create(:crew_change, employee: ed, date: end1, action: 'Out', project: fred)

    data = POBSummaryReport.new(end_date: '2015-06-20').data.should be_empty
  end

  it 'correctly stops when an employees stay overlaps an end date' do
    ed = FactoryGirl.create(:employee)
    fred = FactoryGirl.create(:project)

    start1 = Date.parse('2015-07-01')
    end1 = Date.parse('2015-07-10')

    in1 = FactoryGirl.create(:crew_change, employee: ed, date: start1, action: 'In', project: fred)
    out1 = FactoryGirl.create(:crew_change, employee: ed, date: end1, action: 'Out', project: fred)

    datum = POBSummaryReport.new(end_date: '2015-07-03').data.first
    datum.start_date.should == Date.parse('2015-07-01')
    datum.end_date.should == Date.parse('2015-07-03')
  end

  it 'filters by employee' do
    ed = FactoryGirl.create(:employee)
    ned = FactoryGirl.create(:employee)
    fred = FactoryGirl.create(:project)

    start1 = Date.parse('2015-07-01')
    end1 = Date.parse('2015-07-10')

    FactoryGirl.create(:crew_change, employee: ed, date: start1, action: 'In', project: fred)
    FactoryGirl.create(:crew_change, employee: ed, date: end1, action: 'Out', project: fred)

    POBSummaryReport.new(employee_id: ned.id).data.should be_empty
  end

  it 'shows no results if require_parameters is set and no OTHER parameters are set' do
    ed = FactoryGirl.create(:employee)
    ned = FactoryGirl.create(:employee)
    fred = FactoryGirl.create(:project)

    start1 = Date.parse('2015-07-01')
    end1 = Date.parse('2015-07-10')

    FactoryGirl.create(:crew_change, employee: ed, date: start1, action: 'In', project: fred)
    FactoryGirl.create(:crew_change, employee: ed, date: end1, action: 'Out', project: fred)

    POBSummaryReport.new(require_params: true).data.should be_empty
  end
end
