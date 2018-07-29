class RemoveManyThings < ActiveRecord::Migration
  def change
    drop_table :assignments do |t|
      t.integer  "project_id",    limit: 4
      t.integer  "employee_id",   limit: 4
      t.integer  "position_id",   limit: 4
      t.decimal  "rate",                      precision: 10, scale: 2
      t.string   "rate_interval", limit: 8
      t.string   "po_number",     limit: 255
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    drop_table "customers", force: :cascade do |t|
      t.string "name", limit: 255
    end

    drop_table "departure_sites", force: :cascade do |t|
      t.string "name",     limit: 255
      t.string "category", limit: 255
      t.text   "details",  limit: 65535
    end

    drop_table "jobs", force: :cascade do |t|
      t.integer  "project_id",       limit: 4
      t.integer  "employee_id",      limit: 4
      t.integer  "position_id",      limit: 4
      t.decimal  "rate",                           precision: 10, scale: 2
      t.string   "rate_interval",    limit: 8
      t.decimal  "hours_per_day",                  precision: 10
      t.date     "onboarding_date"
      t.date     "offboarding_date"
      t.text     "note",             limit: 65535
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    drop_table "oil_cos", force: :cascade do |t|
      t.string "name", limit: 255
    end

    drop_table "projects", force: :cascade do |t|
      t.string   "name",              limit: 255
      t.integer  "oil_co_id",         limit: 4
      t.integer  "customer_id",       limit: 4
      t.integer  "departure_site_id", limit: 4
      t.integer  "work_site_id",      limit: 4
      t.date     "start_date"
      t.date     "end_date"
      t.string   "email",             limit: 255
      t.string   "phone",             limit: 255
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    drop_table "work_sites", force: :cascade do |t|
      t.string "name",    limit: 255
      t.text   "details", limit: 65535
    end
  end
end
