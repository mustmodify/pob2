class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.integer :project_id
      t.integer :employee_id
      t.integer :position_id
      t.decimal :daily_rate

      t.date :onboarding_date
      t.date :offboarding_date

      t.text :note
      t.timestamps
    end

    drop_table :crew_changes do |t|
      t.date    "date"
      t.integer "project_id",  limit: 4
      t.string  "action",      limit: 255
      t.integer "employee_id", limit: 4
      t.integer "position_id", limit: 4
      t.decimal "rate",                      precision: 10
      t.text    "note",        limit: 65535
    end
  end
end
