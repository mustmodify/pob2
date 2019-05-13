class ProjectRedux < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.boolean :active, :default => true
      t.string :client
      t.string :email, limit: 120
      t.string :phone, limit: 25
      t.timestamps
    end

    create_table :events do |t|
      t.integer :project_id
      t.integer :user_id
      t.string :action
      t.timestamps
    end

    create_table :jobs do |t|
      t.integer :project_id
      t.integer :employee_id
      t.integer :position_id
      t.date :start_date
      t.date :end_date
      t.timestamps
    end
  end
end
