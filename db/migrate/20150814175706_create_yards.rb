class CreateYards < ActiveRecord::Migration
  def change
    create_table :yards do |t|
      t.string :name
    end
  end
end
