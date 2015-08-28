class EmployeeStatus < ActiveRecord::Migration
  def change
    add_column :employees, :status, :string, :limit => 15, :after => :bag_weight, default: 'Active'
  end
end
