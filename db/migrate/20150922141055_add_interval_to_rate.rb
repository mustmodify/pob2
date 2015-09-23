class AddIntervalToRate < ActiveRecord::Migration
  def change
    add_column :competencies, :rate_interval, :string, :limit => 8, :after => 'rate', :default => 'day'

    rename_column :jobs, :daily_rate, :rate
    add_column :jobs, :rate_interval, :string, :limit => 8, :after => 'rate'

    rename_column :assignments, :daily_rate, :rate
    add_column :assignments, :rate_interval, :string, :limit => 8, :after => 'rate'
  end
end
