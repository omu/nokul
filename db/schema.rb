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

ActiveRecord::Schema.define(version: 2018_05_07_131709) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.integer "district_id", null: false
    t.string "neighbourhood"
    t.text "full_address", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_addresses_on_user_id"
  end

  create_table "cities", force: :cascade do |t|
    t.string "name", null: false
    t.string "iso", null: false
    t.string "nuts_code", null: false
    t.bigint "region_id"
    t.index ["region_id"], name: "index_cities_on_region_id"
  end

  create_table "countries", force: :cascade do |t|
    t.string "name", null: false
    t.string "iso", null: false
    t.integer "code", null: false
  end

  create_table "districts", force: :cascade do |t|
    t.string "name", null: false
    t.integer "yoksis_id"
    t.bigint "city_id"
    t.index ["city_id"], name: "index_districts_on_city_id"
  end

  create_table "identities", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "mothers_name"
    t.string "fathers_name"
    t.integer "gender", null: false
    t.integer "marital_status", null: false
    t.string "place_of_birth", null: false
    t.date "date_of_birth", null: false
    t.string "registered_to"
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_identities_on_user_id"
  end

  create_table "regions", force: :cascade do |t|
    t.string "name", null: false
    t.string "nuts_code", null: false
    t.bigint "country_id"
    t.index ["country_id"], name: "index_regions_on_country_id"
  end

  create_table "staff_academic_titles", force: :cascade do |t|
    t.string "name", null: false
    t.integer "code", null: false
  end

  create_table "staff_administrative_functions", force: :cascade do |t|
    t.string "name", null: false
    t.integer "code", null: false
  end

  create_table "student_disability_types", force: :cascade do |t|
    t.string "name", null: false
    t.integer "code", null: false
  end

  create_table "student_drop_out_types", force: :cascade do |t|
    t.string "name", null: false
    t.integer "code", null: false
  end

  create_table "student_education_levels", force: :cascade do |t|
    t.string "name", null: false
    t.integer "code", null: false
  end

  create_table "student_entrance_point_types", force: :cascade do |t|
    t.string "name", null: false
    t.integer "code", null: false
  end

  create_table "student_entrance_types", force: :cascade do |t|
    t.string "name", null: false
    t.integer "code", null: false
  end

  create_table "student_grades", force: :cascade do |t|
    t.string "name", null: false
    t.integer "code", null: false
  end

  create_table "student_grading_systems", force: :cascade do |t|
    t.string "name", null: false
    t.integer "code", null: false
  end

  create_table "student_punishment_types", force: :cascade do |t|
    t.string "name", null: false
    t.integer "code", null: false
  end

  create_table "student_studentship_statuses", force: :cascade do |t|
    t.string "name", null: false
    t.integer "code", null: false
  end

  create_table "unit_instruction_languages", force: :cascade do |t|
    t.string "name", null: false
    t.integer "code", null: false
  end

  create_table "unit_instruction_types", force: :cascade do |t|
    t.string "name", null: false
    t.integer "code", null: false
  end

  create_table "unit_statuses", force: :cascade do |t|
    t.string "name", null: false
    t.integer "code", null: false
  end

  create_table "units", force: :cascade do |t|
    t.string "name", null: false
    t.integer "yoksis_id", null: false
    t.integer "foet_code"
    t.date "founded_at"
    t.integer "duration"
    t.string "type", null: false
    t.bigint "district_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "ancestry"
    t.integer "unit_status_id"
    t.integer "unit_type_id"
    t.integer "unit_instruction_language_id"
    t.integer "unit_instruction_type_id"
    t.integer "university_type_id"
    t.index ["ancestry"], name: "index_units_on_ancestry"
    t.index ["district_id"], name: "index_units_on_district_id"
  end

  create_table "university_types", force: :cascade do |t|
    t.string "name", null: false
    t.integer "code", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "id_number", null: false
    t.string "email", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["id_number"], name: "index_users_on_id_number", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "yoksis_responses", force: :cascade do |t|
    t.string "name", null: false
    t.string "endpoint", null: false
    t.string "action", null: false
    t.string "sha1", null: false
    t.datetime "created_at", null: false
    t.datetime "syncronized_at"
  end

  add_foreign_key "addresses", "users"
  add_foreign_key "cities", "regions"
  add_foreign_key "districts", "cities"
  add_foreign_key "identities", "users"
  add_foreign_key "regions", "countries"
  add_foreign_key "units", "districts"
end
