class ComplimentsAndReprimandsHaveAttachedImages < ActiveRecord::Migration
  def change
    add_column :compliments, :image_file_name, :string, :after => :note
    add_column :compliments, :image_content_type, :string, :after => :image_file_name
    add_column :compliments, :image_file_size, :integer, :after => :image_content_type

    add_column :reprimands, :image_file_name, :string, :after => :note
    add_column :reprimands, :image_content_type, :string, :after => :image_file_name 
    add_column :reprimands, :image_file_size, :integer, :after => :image_content_type
  end
end
