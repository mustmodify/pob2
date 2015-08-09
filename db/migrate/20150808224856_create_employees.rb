class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.date :dob
      t.string :nationality
      t.string :ssn
      t.string :gsn
      t.boolean :transportation_needed
      t.integer :body_weight
      t.integer :bag_weight
      t.boolean :eligible_for_rehire

      t.string :cell_phone
      t.string :home_phone
      t.string :alt_phone

      t.string :street1
      t.string :street2
      t.string :city
      t.string :state, limit: 2
      t.string :zipcode, limit: 5

      t.timestamps null: false
    end
  end
end
