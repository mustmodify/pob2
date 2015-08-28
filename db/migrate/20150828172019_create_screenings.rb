class CreateScreenings < ActiveRecord::Migration
  def change
    create_table :screenings do |t|
      t.integer :employee_id
      t.date :date
      t.string :outcome
      t.string :image_file_name
      t.string :image_content_type
      t.integer :image_file_size
    end
  end
end
