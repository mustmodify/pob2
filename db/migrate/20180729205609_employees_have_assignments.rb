class EmployeesHaveAssignments < ActiveRecord::Migration
  def change
    add_column :employees, :assignment, :string, :after => :status, :limit => 250
  end
end
