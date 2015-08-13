class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string   "email"
      t.string :first_name
      t.string :last_name
      t.boolean  "active",              limit: 1,   default: true
      t.string   "password_digest",     limit: 255
      t.string   "persistence_token",   limit: 255
      t.string   "perishable_token",    limit: 255
      t.string   "single_access_token", limit: 255
      t.integer  "login_count",         limit: 4
      t.datetime "last_request_at"
      t.datetime "created_at"
      t.datetime "updated_at"
    end
  end
end
