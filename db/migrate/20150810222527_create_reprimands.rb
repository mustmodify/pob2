class CreateReprimands < ActiveRecord::Migration
  def change
    create_table :reprimand_categories do |t|
      t.string :name
    end

    create_table :reprimands do |t|
      t.integer :employee_id
      t.string :reprimand_category_id
      t.date :date
      t.text :note

      t.timestamps null: false
    end
  end
end
