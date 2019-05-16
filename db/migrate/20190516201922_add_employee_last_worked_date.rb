class AddEmployeeLastWorkedDate < ActiveRecord::Migration
  def change
    add_column :employees, :pool, :string, :after => :email
    add_column :employees, :last_worked_on, :date, after: :pool
    Q.tell %|update employees SET pool = "#{POOL[1]}"|
  end
end
