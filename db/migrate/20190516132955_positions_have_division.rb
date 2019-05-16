class PositionsHaveDivision < ActiveRecord::Migration
  def change
    add_column :positions, :division, :string, :limit => 20, :after => :name
  end
end
