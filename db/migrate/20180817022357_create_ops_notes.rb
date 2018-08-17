class CreateOpsNotes < ActiveRecord::Migration
  def change
    create_table :ops_notes do |t|
      t.text :body
      t.timestamps
    end
  end
end
