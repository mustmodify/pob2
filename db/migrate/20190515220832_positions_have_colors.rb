class PositionsHaveColors < ActiveRecord::Migration
  def change
    add_column :positions, :color, :string, :limit => 10, :after => :name
  end
end
