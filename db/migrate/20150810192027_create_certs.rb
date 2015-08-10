class CreateCerts < ActiveRecord::Migration
  def change
    create_table :certs do |t|
      t.integer :employee_id
      t.string :description
      t.date :expires_on

      t.string :image_file_name, :string
      t.string :image_content_type, :string
      t.string :image_file_size, :integer
      t.string :image_updated_at, :datetime

      t.timestamps null: false
    end
  end
end
