class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.integer :employee_id

      t.string :name
      t.string :relationship
      t.string :home_phone
      t.string :cell_phone
      t.string :alt_phone

      t.timestamps
    end
  end
end
