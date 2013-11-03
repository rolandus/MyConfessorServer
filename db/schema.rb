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

ActiveRecord::Schema.define(version: 20131103035500) do

  create_table "account_roles", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "account_roles_user_accounts", id: false, force: true do |t|
    t.integer "account_role_id"
    t.integer "user_account_id"
  end

  create_table "account_statuses", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "confession_location_changes", force: true do |t|
    t.string   "name"
    t.string   "nickname"
    t.string   "street_address"
    t.string   "city"
    t.integer  "state_id"
    t.string   "postal_code"
    t.string   "change_comments"
    t.integer  "user_account_id"
    t.integer  "confession_location_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "confession_location_changes", ["confession_location_id"], name: "index_confession_location_changes_on_confession_location_id"

  create_table "confession_locations", force: true do |t|
    t.string   "name"
    t.string   "nickname"
    t.string   "street_address"
    t.string   "city"
    t.integer  "state_id"
    t.string   "postal_code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "confession_locations", ["state_id"], name: "index_confession_locations_on_state_id"

  create_table "confession_statuses", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "confessor_offices", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "confessor_request_statuses", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "confessors", force: true do |t|
    t.integer  "confessor_office_id"
    t.string   "salutation"
    t.integer  "confession_status_id"
    t.integer  "confession_location_id"
    t.datetime "confession_start_time"
    t.datetime "confession_end_time"
    t.string   "confession_comments"
    t.text     "biography"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "confessors", ["confession_location_id"], name: "index_confessors_on_confession_location_id"
  add_index "confessors", ["confession_status_id"], name: "index_confessors_on_confession_status_id"
  add_index "confessors", ["confessor_office_id"], name: "index_confessors_on_confessor_office_id"

  create_table "dioceses", force: true do |t|
    t.string   "name"
    t.string   "full_name"
    t.integer  "state_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "dioceses", ["state_id"], name: "index_dioceses_on_state_id"

  create_table "states", force: true do |t|
    t.string   "name"
    t.string   "abbreviation"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_account_changes", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "username"
    t.string   "password"
    t.integer  "account_status_id"
    t.string   "email"
    t.string   "home_phone"
    t.string   "work_phone"
    t.string   "mobile_phone"
    t.integer  "confessor_id"
    t.integer  "changed_by_user_account_id"
    t.string   "change_comments"
    t.integer  "user_account_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_account_changes", ["user_account_id"], name: "index_user_account_changes_on_user_account_id"

  create_table "user_accounts", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "username"
    t.string   "password"
    t.integer  "account_status_id"
    t.string   "email"
    t.string   "home_phone"
    t.string   "work_phone"
    t.string   "mobile_phone"
    t.integer  "confessor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_accounts", ["account_status_id"], name: "index_user_accounts_on_account_status_id"
  add_index "user_accounts", ["confessor_id"], name: "index_user_accounts_on_confessor_id"

end
