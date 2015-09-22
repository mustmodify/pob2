class DefaultValueForEmployeeAddressState < ActiveRecord::Migration
  def up
    change_column :employees, :state, :string, :limit => 2, :default => 'LA'
  end

  def down
    change_column :employees, :state, :string, :limit => 2
  end
end
