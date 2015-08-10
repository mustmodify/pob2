class EmployeePictures < ActiveRecord::Migration
  def change
    add_column :employees, :picture_file_name, :string, :after => :zipcode
    add_column :employees, :picture_content_type, :string, :after => :picture_file_name
    add_column :employees, :picture_file_size, :string, :after => :picture_content_type
    add_column :employees, :picture_updated_at, :string, :after => :picture_file_size
  end
end
