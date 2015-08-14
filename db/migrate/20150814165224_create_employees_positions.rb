class CreateEmployeesPositions < ActiveRecord::Migration
  def change
    create_table :competencies do |t|
      t.integer :employee_id
      t.integer :position_id
      t.timestamps
    end
  end
end
