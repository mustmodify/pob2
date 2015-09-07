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

  def employee_id
    self.job.employee_id
  end

  def remove_invalid_entries!( list )
    list.reject!{|list| list.size < 2}
  end

  def fire
    date_ranges = []
    job_dates = job.dates.to_a

    i = job_dates.index(self.date)

    date_ranges = [job_dates[0..i], job_dates[i..i+1], job_dates[(i+1)..-1]]
    remove_invalid_entries!( date_ranges )

    original_dates = date_ranges.shift

    self.job.onboarding_date = original_dates.first
    self.job.offboarding_date = original_dates.last
    self.job.save

    date_ranges.each_with_index do |date_list, i|
      create_job( date_list, i == 0 ? self.hours_worked : job.hours_per_day )
    end
  end

  def create_job(date_list, hours)
    onb = date_list.first
    offb = date_list.last

    Job.create!(
      project_id: job.project_id,
      employee_id: job.employee_id,
      position_id: job.position_id,
      daily_rate: job.daily_rate,
      hours_per_day: hours,

      onboarding_date: onb,
      offboarding_date: offb,

      note: self.note
    )
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
