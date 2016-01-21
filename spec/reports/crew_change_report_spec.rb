require 'spec_helper'

describe CrewChangeReport do

  it "excludes an employee's job ending and beginning on the same day." do
    job1 = FactoryGirl.create(:job, 
               onboarding_date: '2013-02-01', 
               offboarding_date: '2013-02-14'
           )

    job2 = FactoryGirl.create(:job, 
               onboarding_date: '2013-02-14', 
               offboarding_date: '2013-02-18'
           )

    ccr = CrewChangeReport.search(Date.parse('2013-02-10'), Date.parse('2013-02-17'))
    ccr.should_not include(job1)
    ccr.should_not include(job2)
  end
end
