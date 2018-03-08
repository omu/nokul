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

ActiveRecord::Schema.define(version: 20180306151011) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "academies", force: :cascade do |t|
    t.string "name"
    t.integer "yoksis_id"
    t.integer "status", default: 0
    t.date "founded_at"
    t.bigint "university_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["university_id"], name: "index_academies_on_university_id"
  end

  create_table "cities", force: :cascade do |t|
    t.string "name"
    t.string "iso"
    t.string "nuts_code"
    t.bigint "region_id"
    t.bigint "country_id"
    t.index ["country_id"], name: "index_cities_on_country_id"
    t.index ["region_id"], name: "index_cities_on_region_id"
  end

  create_table "countries", force: :cascade do |t|
    t.string "name"
    t.string "iso"
    t.string "code"
  end

  create_table "departments", force: :cascade do |t|
    t.string "name"
    t.integer "yoksis_id"
    t.boolean "active"
    t.string "language_code"
    t.date "founded_at"
    t.string "unit_type"
    t.bigint "unit_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["unit_type", "unit_id"], name: "index_departments_on_unit_type_and_unit_id"
  end

  create_table "doctoral_programs", force: :cascade do |t|
    t.string "name"
    t.integer "yoksis_id"
    t.boolean "active"
    t.string "language_code"
    t.date "founded_at"
    t.integer "program_type"
    t.integer "duration"
    t.bigint "institute_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["institute_id"], name: "index_doctoral_programs_on_institute_id"
  end

  create_table "faculties", force: :cascade do |t|
    t.string "name"
    t.integer "yoksis_id"
    t.integer "status", default: 0
    t.date "founded_at"
    t.bigint "university_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["university_id"], name: "index_faculties_on_university_id"
  end

  create_table "institutes", force: :cascade do |t|
    t.string "name"
    t.integer "yoksis_id"
    t.integer "status", default: 0
    t.date "founded_at"
    t.bigint "university_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["university_id"], name: "index_institutes_on_university_id"
  end

  create_table "interdisciplinary_departments", force: :cascade do |t|
    t.string "name"
    t.integer "yoksis_id"
    t.boolean "active"
    t.string "language_code"
    t.date "founded_at"
    t.integer "program_type"
    t.integer "duration"
    t.bigint "institute_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["institute_id"], name: "index_interdisciplinary_departments_on_institute_id"
  end

  create_table "master_programs", force: :cascade do |t|
    t.string "name"
    t.integer "yoksis_id"
    t.boolean "active"
    t.string "language_code"
    t.date "founded_at"
    t.integer "program_type"
    t.integer "duration"
    t.bigint "institute_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["institute_id"], name: "index_master_programs_on_institute_id"
  end

  create_table "proficiency_in_art_programs", force: :cascade do |t|
    t.string "name"
    t.integer "yoksis_id"
    t.boolean "active"
    t.string "language_code"
    t.date "founded_at"
    t.integer "program_type"
    t.integer "duration"
    t.bigint "institute_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["institute_id"], name: "index_proficiency_in_art_programs_on_institute_id"
  end

  create_table "regions", force: :cascade do |t|
    t.string "name"
    t.string "nuts_code"
    t.bigint "country_id"
    t.index ["country_id"], name: "index_regions_on_country_id"
  end

  create_table "undergraduate_programs", force: :cascade do |t|
    t.string "name"
    t.integer "yoksis_id"
    t.boolean "active"
    t.string "language_code"
    t.date "founded_at"
    t.string "program_type"
    t.integer "duration"
    t.bigint "program_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["program_type", "program_id"], name: "index_undergraduate_programs_on_program_type_and_program_id"
  end

  create_table "universities", force: :cascade do |t|
    t.string "name"
    t.string "short_name"
    t.integer "university_type", default: 0
    t.integer "yoksis_id"
    t.integer "status", default: 0
    t.date "founded_at"
    t.bigint "city_id"
    t.index ["city_id"], name: "index_universities_on_city_id"
  end

  create_table "vocational_schools", force: :cascade do |t|
    t.string "name"
    t.integer "yoksis_id"
    t.integer "status", default: 0
    t.date "founded_at"
    t.bigint "university_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["university_id"], name: "index_vocational_schools_on_university_id"
  end

  add_foreign_key "academies", "universities"
  add_foreign_key "cities", "countries"
  add_foreign_key "cities", "regions"
  add_foreign_key "doctoral_programs", "institutes"
  add_foreign_key "faculties", "universities"
  add_foreign_key "institutes", "universities"
  add_foreign_key "interdisciplinary_departments", "institutes"
  add_foreign_key "master_programs", "institutes"
  add_foreign_key "proficiency_in_art_programs", "institutes"
  add_foreign_key "regions", "countries"
  add_foreign_key "universities", "cities"
  add_foreign_key "vocational_schools", "universities"
end
