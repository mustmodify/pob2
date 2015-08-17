# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150817153535) do

  create_table "certs", force: :cascade do |t|
    t.integer  "employee_id"
    t.string   "description"
    t.date     "expires_on"
    t.string   "image_file_name"
    t.string   "string"
    t.string   "image_content_type"
    t.string   "image_file_size"
    t.string   "integer"
    t.string   "image_updated_at"
    t.string   "datetime"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "competencies", force: :cascade do |t|
    t.integer  "employee_id"
    t.integer  "position_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contacts", force: :cascade do |t|
    t.integer  "employee_id"
    t.string   "name"
    t.string   "relationship"
    t.string   "home_phone"
    t.string   "cell_phone"
    t.string   "alt_phone"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "customers", force: :cascade do |t|
    t.string "name"
  end

  create_table "employees", force: :cascade do |t|
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "last_name"
    t.date     "dob"
    t.string   "email"
    t.string   "nationality"
    t.string   "ssn"
    t.string   "gsn"
    t.boolean  "transportation_needed"
    t.integer  "body_weight"
    t.integer  "bag_weight"
    t.boolean  "eligible_for_rehire"
    t.string   "cell_phone"
    t.string   "home_phone"
    t.string   "alt_phone"
    t.string   "street1"
    t.string   "street2"
    t.string   "city"
    t.string   "state",                 limit: 2
    t.string   "zipcode",               limit: 5
    t.string   "ident_issuer"
    t.string   "ident_number"
    t.date     "ident_issue_date"
    t.date     "ident_expiration_date"
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  create_table "heliports", force: :cascade do |t|
    t.string "name"
  end

  create_table "notes", force: :cascade do |t|
    t.integer  "employee_id"
    t.text     "body"
    t.integer  "author_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "oil_cos", force: :cascade do |t|
    t.string "name"
  end

  create_table "positions", force: :cascade do |t|
    t.string   "name"
    t.decimal  "rate"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reprimand_categories", force: :cascade do |t|
    t.string "name"
  end

  create_table "reprimands", force: :cascade do |t|
    t.integer  "employee_id"
    t.string   "reprimand_category_id"
    t.date     "date"
    t.text     "note"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "restrictions", force: :cascade do |t|
    t.integer  "employee_id"
    t.date     "effective_date"
    t.string   "title"
    t.string   "description"
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "first_name"
    t.string   "last_name"
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

  create_table "work_sites", force: :cascade do |t|
    t.string "name"
    t.text   "details"
  end

end
