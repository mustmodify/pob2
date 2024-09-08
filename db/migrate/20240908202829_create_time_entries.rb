class CreateTimeEntries < ActiveRecord::Migration
  def change
    create_table :time_entries do |t|
      t.integer :employee_id
      t.integer :assignment_id
      t.date :date
      t.decimal :hours, default: 12
      t.text :notes

      t.timestamps null: false
    end
  end
end
