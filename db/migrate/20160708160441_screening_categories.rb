class ScreeningCategories < ActiveRecord::Migration
  def change
    add_column :screenings, :category, :string, :after => :employee_id, :limit => 15
  end
end
