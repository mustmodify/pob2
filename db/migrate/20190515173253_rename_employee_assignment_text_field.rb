class RenameEmployeeAssignmentTextField < ActiveRecord::Migration
  def change
    rename_column :employees, :assignment, :alerts
  end
end
