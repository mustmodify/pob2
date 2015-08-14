class CreateHeliports < ActiveRecord::Migration
  def change
    create_table :heliports do |t|
      t.string :name
    end
  end
end
