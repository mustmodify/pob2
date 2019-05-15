class RenameJobsToAssignments < ActiveRecord::Migration
  def change
    rename_table :jobs, :assignments
  end
end
