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

ActiveRecord::Schema.define(version: 20131017030707) do

  create_table "confessional_locations", force: true do |t|
    t.string   "name"
    t.string   "nickname"
    t.string   "street_address"
    t.string   "city"
    t.integer  "state"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_locations", force: true do |t|
    t.integer  "user_id"
    t.integer  "confessional_location_id"
    t.text     "location_details"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_locations", ["confessional_location_id", "user_id"], name: "index_user_locations_on_confessional_location_id_and_user_id", unique: true

  create_table "users", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "home_phone"
    t.string   "mobile_phone"
    t.string   "email"
    t.string   "street_address"
    t.string   "city"
    t.integer  "state"
    t.string   "diocese"
    t.string   "parish"
    t.string   "password"
    t.integer  "office"
    t.string   "salutation"
    t.binary   "photo"
    t.text     "about_me"
    t.integer  "account_status"
    t.integer  "confessional_status"
    t.integer  "confessional_location_id"
    t.date     "confessional_date"
    t.time     "confessional_start_time"
    t.time     "confessional_end_time"
    t.text     "confessional_details"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
