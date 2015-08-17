class CreateCrewChange < ActiveRecord::Migration
  def change
    create_table :crew_changes do |t|
      t.date :date
      t.integer :project_id
      t.string :action
      t.integer :employee_id
      t.integer :position_id
      t.decimal :rate

      t.text :note
    end
  end
end
