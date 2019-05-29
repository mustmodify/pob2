class DefaultEmployeePool < ActiveRecord::Migration
  def change
    change_column :employees, :pool, :string, :default => 'New'
  end
end
