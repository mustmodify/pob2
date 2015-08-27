class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.integer :project_id
      t.integer :employee_id
      t.integer :position_id
      t.decimal :daily_rate
    end

    add_index :assignments, [:project_id, :employee_id, :position_id]
  end
end
