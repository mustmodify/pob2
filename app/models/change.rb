class Change < Valuable
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  validate :must_have_job_with_ending
  validate :must_have_date_in_range

  has_value :job, :klass => Job, :parse_with => :find, :alias => :job_id
  has_value :date, :klass => Date, :parse_with => :parse
  has_value :hours_worked, :klass => :decimal
  has_value :note

  def fire
    date_ranges = []
    job_dates = job.dates.to_a

    i = job_dates.index(self.date)

    if( i == 0 )
      date_ranges = [[self.date], job_dates[1..-1]].reject(&:empty?)
    elsif( i == job_dates.size - 1 )
      date_ranges = [job_dates[0..-2], [self.date]].reject(&:empty?)
    else
      date_ranges = [job_dates[0...i], job_dates[i..i], job_dates[(i+1)..-1]]
    end

    original_dates = date_ranges.shift

    self.job.onboarding_date = original_dates.first
    self.job.offboarding_date = original_dates.last
    self.job.save

    date_ranges.each do |date_list|
      onb = date_list.first
      offb = date_list.last

      Job.create!(
        project_id: job.project_id,
        employee_id: job.employee_id,
        position_id: job.position_id,
        daily_rate: job.daily_rate,
        hours_per_day: self.hours_worked,

        onboarding_date: onb, 
        offboarding_date: offb,

        note: self.note
      )
    end
  end

  def job_id
    self.job.id
  end

  def must_have_job_with_ending
    errors[:job] << "can't be changed because it has no end date" unless job.dates
  end

  def must_have_date_in_range
    errors[:date] << "is not during this job" unless job.dates && job.dates.include?( self.date )
  end

  def persisted?
    false
  end
end
