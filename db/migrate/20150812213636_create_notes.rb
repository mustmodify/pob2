class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.integer :employee_id
      t.text :body
      t.integer :author_id

      t.timestamps
    end
  end
end
