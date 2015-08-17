class PositionsDoNotHaveARate < ActiveRecord::Migration
  def change
    remove_column :positions, :rate, :decimal
  end
end
