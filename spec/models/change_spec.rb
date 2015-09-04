require 'spec_helper'

describe Change do
  it 'validates that the date is within the job' do
    job = FactoryGirl.build(:job, onboarding_date: '2014-01-04', offboarding_date: '2014-01-10')
    Change.new(job: job, date: '2014-01-20', hours_worked: 8).should_not be_valid
  end

  it 'validates that the job has an end date' do
    job = FactoryGirl.build(:job, onboarding_date: '2014-01-04', offboarding_date: nil)
    Change.new(job: job, date: '2014-01-05', hours_worked: 8).should_not be_valid
  end

  it 'breaks off the last day of a job' do
    job = FactoryGirl.create(:job, onboarding_date: '2012-02-12', offboarding_date: '2012-02-20', hours_per_day: 12)

    making_change = lambda do
      Change.new(job: job, date: '2012-02-20', hours_worked: '8', note: 'La la la la la').fire
    end

    making_change.should change(Job, :count).by(1)

    job.offboarding_date.should == Date.parse('2012-02-19')
    Job.last.tap do |tail_job|
      tail_job.project_id.should == job.project_id
      tail_job.employee_id.should == job.employee_id
      tail_job.position_id.should == job.position_id
      tail_job.daily_rate.should == job.daily_rate
      tail_job.hours_per_day.should == 8
      tail_job.note.should == 'La la la la la'
    end
  end

  it 'breaks out the middle day of a job' do
    original = FactoryGirl.create(:job, onboarding_date: '2012-02-12', offboarding_date: '2012-02-20', hours_per_day: 12)

    making_change = lambda do
      Change.new(job: original, date: '2012-02-15', hours_worked: '8', note: 'La la la la la').fire
    end

    making_change.should change(Job, :count).by(2)

    jobs = Job.last(2)

    original.offboarding_date.should == Date.parse('2012-02-14')
    jobs.first.onboarding_date.should == Date.parse('2012-02-15')
    jobs.first.offboarding_date.should == Date.parse('2012-02-15')
    jobs.first.hours_per_day.should == 8
    jobs.last.onboarding_date.should == Date.parse('2012-02-16')
    jobs.last.offboarding_date.should == Date.parse('2012-02-20')
    jobs.last.hours_per_day.should == 12
  end
end
