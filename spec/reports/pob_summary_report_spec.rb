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
    data.keys.should have(1).entry
    data.keys.first.should == ed
    data.values.first.should == ((start1..end1).to_a + (start2..end2).to_a)
  end
end
