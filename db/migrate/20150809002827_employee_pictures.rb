class EmployeePictures < ActiveRecord::Migration
  def change
    change_table :employees do |t|
      t.string :picture_file_name, :after => :zipcode
      t.string :picture_content_type, :after => :picture_file_name
      t.integer :picture_file_size, :after => :picture_content_type
      t.datetime :picture_updated_at, :after => :picture_file_size
    end
  end
end
