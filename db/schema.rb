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

ActiveRecord::Schema.define(version: 20131129033211) do

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

  create_table "confessor_changes", force: true do |t|
    t.integer  "confessor_id"
    t.integer  "confessor_office_id"
    t.string   "salutation"
    t.integer  "user_account_id"
    t.text     "biography"
    t.string   "change_comments"
    t.integer  "changed_by_user_account_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "confessor_changes", ["confessor_id"], name: "index_confessor_changes_on_confessor_id"

  create_table "confessor_offices", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "confessor_request_changes", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "diocese_id"
    t.integer  "state_id"
    t.integer  "confessor_request_status_id"
    t.text     "change_comments"
    t.integer  "changed_by_user_account_id"
    t.integer  "confessor_request_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "confessor_request_changes", ["confessor_request_id"], name: "index_confessor_request_changes_on_confessor_request_id"

  create_table "confessor_request_statuses", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "confessor_requests", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "diocese_id"
    t.integer  "state_id"
    t.integer  "confessor_request_status_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "confessor_requests", ["confessor_request_status_id"], name: "index_confessor_requests_on_confessor_request_status_id"
  add_index "confessor_requests", ["diocese_id"], name: "index_confessor_requests_on_diocese_id"
  add_index "confessor_requests", ["state_id"], name: "index_confessor_requests_on_state_id"

  create_table "confessors", force: true do |t|
    t.integer  "confessor_office_id"
    t.string   "salutation"
    t.integer  "user_account_id"
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
  add_index "confessors", ["user_account_id"], name: "index_confessors_on_user_account_id"

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
    t.string   "email",                  default: "", null: false
    t.string   "home_phone"
    t.string   "work_phone"
    t.string   "mobile_phone"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "user_accounts", ["account_status_id"], name: "index_user_accounts_on_account_status_id"
  add_index "user_accounts", ["email"], name: "index_user_accounts_on_email", unique: true
  add_index "user_accounts", ["reset_password_token"], name: "index_user_accounts_on_reset_password_token", unique: true

end
