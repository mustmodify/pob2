class ProjectsHaveContactDetails < ActiveRecord::Migration
  def change
    add_column :projects, :email, :string
    add_column :projects, :phone, :string
    add_column :projects, :created_at, :datetime
    add_column :projects, :updated_at, :datetime
  end
end
