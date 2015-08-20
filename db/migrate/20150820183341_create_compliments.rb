class CreateCompliments < ActiveRecord::Migration
  def change
    create_table :compliments do |t|
      t.integer :employee_id
      t.date :date
      t.text :note

      t.timestamps
    end
  end
end
