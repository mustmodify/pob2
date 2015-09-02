class JobsHaveHoursPerDay < ActiveRecord::Migration
  def change
    add_column :jobs, :hours_per_day, :decimal, after: 'daily_rate'
  end
end
