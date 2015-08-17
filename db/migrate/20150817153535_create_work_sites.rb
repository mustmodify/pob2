class CreateWorkSites < ActiveRecord::Migration
  def change
    create_table :work_sites do |t|
      t.string :name
      t.text   :details
    end

    drop_table :yards do |t|
      t.string :name
    end
  end
end
