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

ActiveRecord::Schema.define(version: 20180316051754) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cities", force: :cascade do |t|
    t.string "name", null: false
    t.string "iso", null: false
    t.string "nuts_code", null: false
    t.bigint "region_id"
    t.bigint "country_id"
    t.index ["country_id"], name: "index_cities_on_country_id"
    t.index ["region_id"], name: "index_cities_on_region_id"
  end

  create_table "countries", force: :cascade do |t|
    t.string "name", null: false
    t.string "iso", null: false
    t.integer "code", null: false
  end

  create_table "positions", force: :cascade do |t|
    t.string "name", null: false
    t.integer "yoksis_id", null: false
  end

  create_table "programs", force: :cascade do |t|
    t.string "name", null: false
    t.integer "yoksis_id", null: false
    t.integer "status", default: 1, null: false
    t.date "founded_at"
    t.integer "instruction_type", default: 1, null: false
    t.integer "foet_code"
    t.string "language"
    t.integer "duration"
    t.string "type", null: false
    t.bigint "unit_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["unit_id"], name: "index_programs_on_unit_id"
  end

  create_table "regions", force: :cascade do |t|
    t.string "name", null: false
    t.string "nuts_code", null: false
    t.bigint "country_id"
    t.index ["country_id"], name: "index_regions_on_country_id"
  end

  create_table "responsibilities", force: :cascade do |t|
    t.bigint "unit_id"
    t.bigint "position_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["position_id"], name: "index_responsibilities_on_position_id"
    t.index ["unit_id"], name: "index_responsibilities_on_unit_id"
  end

  create_table "units", force: :cascade do |t|
    t.string "name", null: false
    t.integer "yoksis_id", null: false
    t.integer "status", default: 1, null: false
    t.date "founded_at"
    t.integer "instruction_type", default: 1, null: false
    t.integer "foet_code"
    t.string "type", null: false
    t.bigint "city_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "ancestry"
    t.index ["ancestry"], name: "index_units_on_ancestry"
    t.index ["city_id"], name: "index_units_on_city_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "type", null: false
    t.integer "id_number", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  create_table "yoksis_responses", force: :cascade do |t|
    t.string "name", null: false
    t.string "endpoint", null: false
    t.string "action", null: false
    t.string "sha1", null: false
    t.datetime "created_at", null: false
    t.datetime "syncronized_at"
  end

  add_foreign_key "cities", "countries"
  add_foreign_key "cities", "regions"
  add_foreign_key "programs", "units"
  add_foreign_key "regions", "countries"
  add_foreign_key "responsibilities", "positions"
  add_foreign_key "responsibilities", "units"
  add_foreign_key "units", "cities"
end
