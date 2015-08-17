class CreateDepartureSites < ActiveRecord::Migration
  def change
    create_table :departure_sites do |t|
      t.string :name
      t.string :category
      t.text :details
    end

    drop_table :heliports do |t|
      t.string :name
    end
  end
end
