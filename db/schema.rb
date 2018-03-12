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

ActiveRecord::Schema.define(version: 20180312115623) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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

  create_table "programs", force: :cascade do |t|
    t.string "name"
    t.integer "yoksis_id"
    t.integer "status", default: 0
    t.date "founded_at"
    t.integer "language"
    t.integer "duration"
    t.string "type"
    t.bigint "unit_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["unit_id"], name: "index_programs_on_unit_id"
  end

  create_table "regions", force: :cascade do |t|
    t.string "name"
    t.string "nuts_code"
    t.bigint "country_id"
    t.index ["country_id"], name: "index_regions_on_country_id"
  end

  create_table "units", force: :cascade do |t|
    t.string "name"
    t.integer "yoksis_id"
    t.integer "status", default: 0
    t.date "founded_at"
    t.string "type"
    t.bigint "university_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "ancestry"
    t.index ["ancestry"], name: "index_units_on_ancestry"
    t.index ["university_id"], name: "index_units_on_university_id"
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

  add_foreign_key "cities", "countries"
  add_foreign_key "cities", "regions"
  add_foreign_key "programs", "units"
  add_foreign_key "regions", "countries"
  add_foreign_key "units", "universities"
  add_foreign_key "universities", "cities"
end
