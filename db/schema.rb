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

ActiveRecord::Schema.define(version: 2018_06_21_072455) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "academic_calendars", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "academic_term_id"
    t.bigint "calendar_type_id"
    t.date "senate_decision_date", null: false
    t.string "senate_decision_no", null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["academic_term_id"], name: "index_academic_calendars_on_academic_term_id"
    t.index ["calendar_type_id"], name: "index_academic_calendars_on_calendar_type_id"
  end

  create_table "academic_terms", force: :cascade do |t|
    t.string "year", null: false
    t.integer "term", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "addresses", force: :cascade do |t|
    t.integer "name", default: 4, null: false
    t.string "phone_number", default: "", null: false
    t.text "full_address", null: false
    t.bigint "district_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["district_id"], name: "index_addresses_on_district_id"
    t.index ["user_id"], name: "index_addresses_on_user_id"
  end

  create_table "administrative_functions", force: :cascade do |t|
    t.string "name", null: false
    t.integer "code", null: false
  end

  create_table "calendar_events", force: :cascade do |t|
    t.bigint "academic_calendar_id"
    t.bigint "calendar_title_id"
    t.datetime "start_date", null: false
    t.datetime "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["academic_calendar_id"], name: "index_calendar_events_on_academic_calendar_id"
    t.index ["calendar_title_id"], name: "index_calendar_events_on_calendar_title_id"
  end

  create_table "calendar_title_types", force: :cascade do |t|
    t.bigint "type_id"
    t.bigint "title_id"
    t.integer "status", default: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["title_id"], name: "index_calendar_title_types_on_title_id"
    t.index ["type_id"], name: "index_calendar_title_types_on_type_id"
  end

  create_table "calendar_titles", force: :cascade do |t|
    t.string "name", null: false
  end

  create_table "calendar_types", force: :cascade do |t|
    t.string "name", null: false
  end

  create_table "cities", force: :cascade do |t|
    t.string "name", null: false
    t.string "iso", null: false
    t.string "nuts_code", null: false
    t.bigint "country_id"
    t.index ["country_id"], name: "index_cities_on_country_id"
  end

  create_table "countries", force: :cascade do |t|
    t.string "name", null: false
    t.string "iso", null: false
    t.integer "code", null: false
  end

  create_table "courses", force: :cascade do |t|
    t.string "name", null: false
    t.string "code", null: false
    t.integer "theoric", null: false
    t.integer "practice", null: false
    t.integer "laboratory", null: false
    t.decimal "credit", precision: 5, scale: 2, default: "0.0", null: false
    t.bigint "unit_id"
    t.integer "education_type", null: false
    t.string "language", null: false
    t.integer "status", null: false
    t.date "abrogated_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["unit_id"], name: "index_courses_on_unit_id"
  end

  create_table "districts", force: :cascade do |t|
    t.string "name", null: false
    t.integer "yoksis_id"
    t.bigint "city_id"
    t.index ["city_id"], name: "index_districts_on_city_id"
  end

  create_table "duties", force: :cascade do |t|
    t.boolean "temporary"
    t.date "start_date"
    t.date "end_date"
    t.bigint "employee_id"
    t.bigint "unit_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_duties_on_employee_id"
    t.index ["unit_id"], name: "index_duties_on_unit_id"
  end

  create_table "employees", force: :cascade do |t|
    t.boolean "active", default: true, null: false
    t.bigint "title_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["title_id"], name: "index_employees_on_title_id"
    t.index ["user_id"], name: "index_employees_on_user_id"
  end

  create_table "identities", force: :cascade do |t|
    t.integer "name", null: false
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "mothers_name"
    t.string "fathers_name"
    t.integer "gender", null: false
    t.integer "marital_status"
    t.string "place_of_birth", null: false
    t.date "date_of_birth", null: false
    t.string "registered_to"
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.bigint "student_id"
    t.index ["student_id"], name: "index_identities_on_student_id"
    t.index ["user_id"], name: "index_identities_on_user_id"
  end

  create_table "positions", force: :cascade do |t|
    t.bigint "duty_id"
    t.bigint "administrative_function_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["administrative_function_id"], name: "index_positions_on_administrative_function_id"
    t.index ["duty_id"], name: "index_positions_on_duty_id"
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

  create_table "students", force: :cascade do |t|
    t.string "student_number", null: false
    t.bigint "user_id"
    t.bigint "unit_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["unit_id"], name: "index_students_on_unit_id"
    t.index ["user_id"], name: "index_students_on_user_id"
  end

  create_table "titles", force: :cascade do |t|
    t.string "name", null: false
    t.string "code", null: false
    t.string "branch", null: false
  end

  create_table "unit_calendar_events", force: :cascade do |t|
    t.bigint "academic_calendar_id"
    t.bigint "unit_id"
    t.bigint "calendar_title_id"
    t.datetime "start_date", null: false
    t.datetime "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["academic_calendar_id"], name: "index_unit_calendar_events_on_academic_calendar_id"
    t.index ["calendar_title_id"], name: "index_unit_calendar_events_on_calendar_title_id"
    t.index ["unit_id"], name: "index_unit_calendar_events_on_unit_id"
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
    t.integer "type", null: false
    t.bigint "district_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "ancestry"
    t.integer "unit_status_id"
    t.integer "unit_instruction_language_id"
    t.integer "unit_instruction_type_id"
    t.integer "university_type_id"
    t.index ["ancestry"], name: "index_units_on_ancestry"
    t.index ["district_id"], name: "index_units_on_district_id"
    t.index ["unit_instruction_language_id"], name: "index_units_on_unit_instruction_language_id"
    t.index ["unit_instruction_type_id"], name: "index_units_on_unit_instruction_type_id"
    t.index ["unit_status_id"], name: "index_units_on_unit_status_id"
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
    t.string "name", null: false, comment: "API endpoint, ie: Yoksis"
    t.string "endpoint", null: false, comment: "API endpoint name, ie: Referanslar"
    t.string "action", null: false, comment: "Endpoint action, ie: get_ogrenim_dili_response"
    t.string "sha1", null: false, comment: "SHA1 hash of the API response"
    t.datetime "created_at", null: false
    t.datetime "syncronized_at"
  end

  add_foreign_key "academic_calendars", "academic_terms"
  add_foreign_key "academic_calendars", "calendar_types"
  add_foreign_key "addresses", "districts"
  add_foreign_key "addresses", "users"
  add_foreign_key "calendar_events", "academic_calendars"
  add_foreign_key "calendar_events", "calendar_titles"
  add_foreign_key "calendar_title_types", "calendar_titles", column: "title_id"
  add_foreign_key "calendar_title_types", "calendar_types", column: "type_id"
  add_foreign_key "cities", "countries"
  add_foreign_key "courses", "units"
  add_foreign_key "districts", "cities"
  add_foreign_key "duties", "employees"
  add_foreign_key "duties", "units"
  add_foreign_key "employees", "titles"
  add_foreign_key "employees", "users"
  add_foreign_key "identities", "students"
  add_foreign_key "identities", "users"
  add_foreign_key "positions", "administrative_functions"
  add_foreign_key "positions", "duties"
  add_foreign_key "students", "units"
  add_foreign_key "students", "users"
  add_foreign_key "unit_calendar_events", "academic_calendars"
  add_foreign_key "unit_calendar_events", "calendar_titles"
  add_foreign_key "unit_calendar_events", "units"
  add_foreign_key "units", "districts"
end
