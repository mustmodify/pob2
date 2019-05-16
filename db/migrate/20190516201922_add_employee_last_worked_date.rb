class AddEmployeeLastWorkedDate < ActiveRecord::Migration
  def change
    add_column :employees, :pool, :string, :after => :email, default: 'Neutral'
    add_column :employees, :last_worked_on, :date, after: :pool
  end
end
