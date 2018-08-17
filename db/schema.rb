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

ActiveRecord::Schema.define(version: 20180817022357) do

  create_table "cert_names", force: :cascade do |t|
    t.string "name", limit: 255
  end

  create_table "certs", force: :cascade do |t|
    t.integer  "employee_id",        limit: 4
    t.integer  "cert_name_id",       limit: 4
    t.date     "expires_on"
    t.string   "image_file_name",    limit: 255
    t.string   "string",             limit: 255
    t.string   "image_content_type", limit: 255
    t.string   "image_file_size",    limit: 255
    t.string   "integer",            limit: 255
    t.string   "image_updated_at",   limit: 255
    t.string   "datetime",           limit: 255
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  create_table "competencies", force: :cascade do |t|
    t.integer  "employee_id",   limit: 4
    t.integer  "position_id",   limit: 4
    t.decimal  "rate",                    precision: 10, scale: 2
    t.string   "rate_interval", limit: 8,                          default: "day"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "compliments", force: :cascade do |t|
    t.integer  "employee_id",        limit: 4
    t.date     "date"
    t.text     "note",               limit: 65535
    t.string   "image_file_name",    limit: 255
    t.string   "image_content_type", limit: 255
    t.integer  "image_file_size",    limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contacts", force: :cascade do |t|
    t.integer  "employee_id",  limit: 4
    t.string   "name",         limit: 255
    t.string   "relationship", limit: 255
    t.string   "home_phone",   limit: 255
    t.string   "cell_phone",   limit: 255
    t.string   "alt_phone",    limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "customary_certs", force: :cascade do |t|
    t.integer  "position_id",  limit: 4
    t.integer  "cert_name_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "employees", force: :cascade do |t|
    t.string   "first_name",            limit: 255
    t.string   "middle_name",           limit: 255
    t.string   "last_name",             limit: 255
    t.date     "dob"
    t.string   "email",                 limit: 255
    t.string   "nationality",           limit: 255
    t.string   "ssn",                   limit: 255
    t.string   "gsn",                   limit: 255
    t.boolean  "transportation_needed"
    t.integer  "body_weight",           limit: 4
    t.integer  "bag_weight",            limit: 4
    t.string   "status",                limit: 15,  default: "Active"
    t.string   "assignment",            limit: 250
    t.boolean  "eligible_for_rehire"
    t.string   "cell_phone",            limit: 255
    t.string   "home_phone",            limit: 255
    t.string   "alt_phone",             limit: 255
    t.string   "street1",               limit: 255
    t.string   "street2",               limit: 255
    t.string   "city",                  limit: 255
    t.string   "state",                 limit: 2,   default: "LA"
    t.string   "zipcode",               limit: 5
    t.string   "ident_issuer",          limit: 255
    t.string   "ident_number",          limit: 255
    t.date     "ident_issue_date"
    t.date     "ident_expiration_date"
    t.string   "picture_file_name",     limit: 255
    t.string   "picture_content_type",  limit: 255
    t.integer  "picture_file_size",     limit: 4
    t.datetime "picture_updated_at"
    t.datetime "created_at",                                           null: false
    t.datetime "updated_at",                                           null: false
  end

  create_table "notes", force: :cascade do |t|
    t.integer  "employee_id", limit: 4
    t.text     "body",        limit: 65535
    t.integer  "author_id",   limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ops_notes", force: :cascade do |t|
    t.text     "body",       limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "positions", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reprimand_categories", force: :cascade do |t|
    t.string "name", limit: 255
  end

  create_table "reprimands", force: :cascade do |t|
    t.integer  "employee_id",           limit: 4
    t.string   "reprimand_category_id", limit: 255
    t.date     "date"
    t.text     "note",                  limit: 65535
    t.string   "image_file_name",       limit: 255
    t.string   "image_content_type",    limit: 255
    t.integer  "image_file_size",       limit: 4
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  create_table "restrictions", force: :cascade do |t|
    t.integer  "employee_id",             limit: 4
    t.date     "effective_date"
    t.string   "title",                   limit: 255
    t.string   "description",             limit: 255
    t.string   "attachment_file_name",    limit: 255
    t.string   "attachment_content_type", limit: 255
    t.integer  "attachment_file_size",    limit: 4
    t.datetime "attachment_updated_at"
  end

  create_table "screenings", force: :cascade do |t|
    t.integer "employee_id",        limit: 4
    t.string  "category",           limit: 15
    t.date    "date"
    t.string  "outcome",            limit: 255
    t.string  "image_file_name",    limit: 255
    t.string  "image_content_type", limit: 255
    t.integer "image_file_size",    limit: 4
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",               limit: 255
    t.string   "first_name",          limit: 255
    t.string   "last_name",           limit: 255
    t.boolean  "active",                          default: true
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
