class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.integer :oil_co_id
      t.integer :customer_id
      t.integer :departure_site_id
      t.integer :work_site_id
      t.date :start_date
      t.date :end_date
    end
  end
end
