class CreateEmploymentActions < ActiveRecord::Migration
  def change
    create_table :employment_actions do |t|
      t.integer :employee_id
      t.string  :action
      t.date    :date
      t.text    :notes
      t.boolean :deleted, default: false
    end
  end
end
