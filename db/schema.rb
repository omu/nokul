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

ActiveRecord::Schema.define(version: 2018_12_10_221451) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "academic_calendars", force: :cascade do |t|
    t.string "name"
    t.date "senate_decision_date"
    t.string "senate_decision_no"
    t.string "description"
    t.bigint "academic_term_id", null: false
    t.bigint "calendar_type_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["academic_term_id"], name: "index_academic_calendars_on_academic_term_id"
    t.index ["calendar_type_id"], name: "index_academic_calendars_on_calendar_type_id"
  end

  create_table "academic_terms", force: :cascade do |t|
    t.string "year"
    t.integer "term"
    t.datetime "start_of_term"
    t.datetime "end_of_term"
    t.boolean "active", default: false
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name"
    t.string "record_type"
    t.bigint "record_id"
    t.bigint "blob_id"
    t.datetime "created_at"
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key"
    t.string "filename"
    t.string "content_type"
    t.string "metadata"
    t.bigint "byte_size"
    t.string "checksum"
    t.datetime "created_at"
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "addresses", force: :cascade do |t|
    t.integer "type"
    t.string "phone_number"
    t.string "full_address"
    t.bigint "district_id", null: false
    t.bigint "user_id", null: false
    t.datetime "updated_at"
    t.index ["district_id"], name: "index_addresses_on_district_id"
    t.index ["user_id"], name: "index_addresses_on_user_id"
  end

  create_table "administrative_functions", force: :cascade do |t|
    t.string "name"
    t.integer "code"
  end

  create_table "agenda_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "agendas", force: :cascade do |t|
    t.string "description"
    t.integer "status", default: 0
    t.bigint "unit_id", null: false
    t.bigint "agenda_type_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["agenda_type_id"], name: "index_agendas_on_agenda_type_id"
    t.index ["unit_id"], name: "index_agendas_on_unit_id"
  end

  create_table "articles", force: :cascade do |t|
    t.integer "yoksis_id"
    t.integer "scope"
    t.integer "review"
    t.integer "index"
    t.string "title"
    t.string "authors"
    t.integer "number_of_authors"
    t.integer "country"
    t.string "city"
    t.string "journal"
    t.string "language_of_publication"
    t.integer "month"
    t.integer "year"
    t.string "volume"
    t.string "issue"
    t.integer "first_page"
    t.integer "last_page"
    t.string "doi"
    t.string "issn"
    t.integer "access_type"
    t.string "access_link"
    t.string "discipline"
    t.string "keyword"
    t.integer "special_issue"
    t.integer "special_issue_name"
    t.string "sponsored_by"
    t.integer "author_id"
    t.datetime "last_update"
    t.integer "status"
    t.integer "type"
    t.float "incentive_point"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_articles_on_user_id"
  end

  create_table "available_course_groups", force: :cascade do |t|
    t.string "name"
    t.integer "quota"
    t.bigint "available_course_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["available_course_id"], name: "index_available_course_groups_on_available_course_id"
  end

  create_table "available_course_lecturers", force: :cascade do |t|
    t.boolean "coordinator", default: false
    t.bigint "group_id", null: false
    t.bigint "lecturer_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_available_course_lecturers_on_group_id"
    t.index ["lecturer_id"], name: "index_available_course_lecturers_on_lecturer_id"
  end

  create_table "available_courses", force: :cascade do |t|
    t.bigint "academic_term_id", null: false
    t.bigint "curriculum_id", null: false
    t.bigint "course_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["academic_term_id"], name: "index_available_courses_on_academic_term_id"
    t.index ["course_id"], name: "index_available_courses_on_course_id"
    t.index ["curriculum_id"], name: "index_available_courses_on_curriculum_id"
  end

  create_table "calendar_events", force: :cascade do |t|
    t.datetime "start_date"
    t.datetime "end_date"
    t.bigint "academic_calendar_id", null: false
    t.bigint "calendar_title_id", null: false
    t.bigint "calendar_type_id"
    t.bigint "academic_term_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["academic_calendar_id"], name: "index_calendar_events_on_academic_calendar_id"
    t.index ["academic_term_id"], name: "index_calendar_events_on_academic_term_id"
    t.index ["calendar_title_id"], name: "index_calendar_events_on_calendar_title_id"
    t.index ["calendar_type_id"], name: "index_calendar_events_on_calendar_type_id"
  end

  create_table "calendar_title_types", force: :cascade do |t|
    t.bigint "type_id", null: false
    t.bigint "title_id", null: false
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["title_id"], name: "index_calendar_title_types_on_title_id"
    t.index ["type_id"], name: "index_calendar_title_types_on_type_id"
  end

  create_table "calendar_titles", force: :cascade do |t|
    t.string "name"
    t.string "identifier"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "calendar_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "calendar_unit_types", force: :cascade do |t|
    t.bigint "calendar_type_id", null: false
    t.bigint "unit_type_id", null: false
    t.index ["calendar_type_id"], name: "index_calendar_unit_types_on_calendar_type_id"
    t.index ["unit_type_id"], name: "index_calendar_unit_types_on_unit_type_id"
  end

  create_table "calendar_units", force: :cascade do |t|
    t.bigint "academic_calendar_id", null: false
    t.bigint "unit_id", null: false
    t.index ["academic_calendar_id"], name: "index_calendar_units_on_academic_calendar_id"
    t.index ["unit_id"], name: "index_calendar_units_on_unit_id"
  end

  create_table "certifications", force: :cascade do |t|
    t.integer "yoksis_id"
    t.integer "type", default: 1
    t.string "name"
    t.string "content"
    t.string "location"
    t.integer "scope"
    t.string "duration"
    t.date "start_date"
    t.date "end_date"
    t.string "title"
    t.integer "number_of_authors"
    t.string "city_and_country"
    t.datetime "last_update"
    t.float "incentive_point"
    t.integer "status"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_certifications_on_user_id"
  end

  create_table "cities", force: :cascade do |t|
    t.string "name"
    t.string "alpha_2_code"
    t.bigint "country_id", null: false
    t.index ["country_id"], name: "index_cities_on_country_id"
  end

  create_table "committee_decisions", force: :cascade do |t|
    t.string "description"
    t.string "decision_no"
    t.integer "year"
    t.bigint "meeting_agenda_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["meeting_agenda_id"], name: "index_committee_decisions_on_meeting_agenda_id"
  end

  create_table "committee_meetings", force: :cascade do |t|
    t.integer "meeting_no"
    t.date "meeting_date"
    t.integer "year"
    t.bigint "unit_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["unit_id"], name: "index_committee_meetings_on_unit_id"
  end

  create_table "countries", force: :cascade do |t|
    t.string "name"
    t.string "alpha_2_code"
    t.string "alpha_3_code"
    t.string "numeric_code"
    t.string "mernis_code"
    t.integer "yoksis_code"
    t.index ["name"], name: "countries_name_unique", unique: true
  end

  create_table "course_group_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "course_groups", force: :cascade do |t|
    t.string "name"
    t.integer "total_ects_condition"
    t.bigint "unit_id", null: false
    t.bigint "course_group_type_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_group_type_id"], name: "index_course_groups_on_course_group_type_id"
    t.index ["unit_id"], name: "index_course_groups_on_unit_id"
  end

  create_table "course_types", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.decimal "min_credit", precision: 5, scale: 2, default: "0.0"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "courses", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.integer "theoric", default: 0
    t.integer "practice", default: 0
    t.integer "laboratory", default: 0
    t.decimal "credit", precision: 5, scale: 2, default: "0.0"
    t.integer "program_type"
    t.integer "status"
    t.bigint "unit_id", null: false
    t.bigint "language_id", null: false
    t.bigint "course_type_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_type_id"], name: "index_courses_on_course_type_id"
    t.index ["language_id"], name: "index_courses_on_language_id"
    t.index ["unit_id"], name: "index_courses_on_unit_id"
  end

  create_table "curriculum_course_groups", force: :cascade do |t|
    t.bigint "course_group_id", null: false
    t.bigint "curriculum_semester_id", null: false
    t.decimal "ects", precision: 5, scale: 2, default: "0.0"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_group_id"], name: "index_curriculum_course_groups_on_course_group_id"
    t.index ["curriculum_semester_id"], name: "index_curriculum_course_groups_on_curriculum_semester_id"
  end

  create_table "curriculum_courses", force: :cascade do |t|
    t.integer "type"
    t.bigint "course_id", null: false
    t.bigint "curriculum_semester_id", null: false
    t.decimal "ects", precision: 5, scale: 2, default: "0.0"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "curriculum_course_group_id"
    t.index ["course_id"], name: "index_curriculum_courses_on_course_id"
    t.index ["curriculum_course_group_id"], name: "index_curriculum_courses_on_curriculum_course_group_id"
    t.index ["curriculum_semester_id"], name: "index_curriculum_courses_on_curriculum_semester_id"
  end

  create_table "curriculum_programs", force: :cascade do |t|
    t.bigint "unit_id", null: false
    t.bigint "curriculum_id", null: false
    t.index ["curriculum_id"], name: "index_curriculum_programs_on_curriculum_id"
    t.index ["unit_id"], name: "index_curriculum_programs_on_unit_id"
  end

  create_table "curriculum_semesters", force: :cascade do |t|
    t.integer "sequence"
    t.integer "year"
    t.bigint "curriculum_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["curriculum_id"], name: "index_curriculum_semesters_on_curriculum_id"
  end

  create_table "curriculums", force: :cascade do |t|
    t.string "name"
    t.integer "semesters_count", default: 0
    t.integer "status"
    t.bigint "unit_id", null: false
    t.index ["unit_id"], name: "index_curriculums_on_unit_id"
  end

  create_table "districts", force: :cascade do |t|
    t.string "name"
    t.string "mernis_code"
    t.boolean "active", default: true
    t.bigint "city_id", null: false
    t.index ["city_id"], name: "index_districts_on_city_id"
  end

  create_table "documents", force: :cascade do |t|
    t.string "name"
    t.string "statement"
  end

  create_table "duties", force: :cascade do |t|
    t.boolean "temporary", default: true
    t.date "start_date"
    t.date "end_date"
    t.bigint "employee_id", null: false
    t.bigint "unit_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_duties_on_employee_id"
    t.index ["unit_id"], name: "index_duties_on_unit_id"
  end

  create_table "employees", force: :cascade do |t|
    t.boolean "active", default: true
    t.bigint "title_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["title_id"], name: "index_employees_on_title_id"
    t.index ["user_id"], name: "index_employees_on_user_id"
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug"
    t.integer "sluggable_id"
    t.string "sluggable_type"
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"
  end

  create_table "group_courses", force: :cascade do |t|
    t.bigint "course_id", null: false
    t.bigint "course_group_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_group_id"], name: "index_group_courses_on_course_group_id"
    t.index ["course_id"], name: "index_group_courses_on_course_id"
  end

  create_table "high_school_types", force: :cascade do |t|
    t.string "name"
    t.integer "code"
  end

  create_table "identities", force: :cascade do |t|
    t.integer "type"
    t.string "first_name"
    t.string "last_name"
    t.string "mothers_name"
    t.string "fathers_name"
    t.integer "gender"
    t.integer "marital_status"
    t.string "place_of_birth"
    t.date "date_of_birth"
    t.string "registered_to"
    t.datetime "updated_at"
    t.bigint "user_id", null: false
    t.bigint "student_id"
    t.index ["student_id"], name: "index_identities_on_student_id"
    t.index ["user_id"], name: "index_identities_on_user_id"
  end

  create_table "languages", force: :cascade do |t|
    t.string "name"
    t.string "iso"
  end

  create_table "meeting_agendas", force: :cascade do |t|
    t.bigint "agenda_id", null: false
    t.bigint "committee_meeting_id", null: false
    t.integer "sequence_no"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["agenda_id"], name: "index_meeting_agendas_on_agenda_id"
    t.index ["committee_meeting_id"], name: "index_meeting_agendas_on_committee_meeting_id"
  end

  create_table "positions", force: :cascade do |t|
    t.date "start_date"
    t.date "end_date"
    t.bigint "duty_id", null: false
    t.bigint "administrative_function_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["administrative_function_id"], name: "index_positions_on_administrative_function_id"
    t.index ["duty_id"], name: "index_positions_on_duty_id"
  end

  create_table "projects", force: :cascade do |t|
    t.integer "yoksis_id"
    t.string "name"
    t.string "subject"
    t.integer "status"
    t.date "start_date"
    t.date "end_date"
    t.string "budget"
    t.string "duty"
    t.string "type"
    t.string "currency"
    t.datetime "last_update"
    t.integer "activity"
    t.integer "scope"
    t.string "title"
    t.integer "unit_id"
    t.float "incentive_point"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_projects_on_user_id"
  end

  create_table "prospective_students", force: :cascade do |t|
    t.string "id_number"
    t.string "first_name"
    t.string "last_name"
    t.string "fathers_name"
    t.string "mothers_name"
    t.date "date_of_birth"
    t.integer "gender"
    t.integer "nationality"
    t.string "place_of_birth"
    t.string "registration_city"
    t.string "registration_district"
    t.string "high_school_code"
    t.string "high_school_branch"
    t.integer "state_of_education"
    t.integer "high_school_graduation_year"
    t.integer "placement_type"
    t.float "exam_score"
    t.string "address"
    t.string "home_phone"
    t.string "mobile_phone"
    t.string "email"
    t.boolean "top_student", default: false
    t.float "placement_score"
    t.integer "placement_rank"
    t.integer "preference_order"
    t.string "placement_score_type"
    t.integer "additional_score"
    t.boolean "meb_status", default: false
    t.datetime "meb_status_date"
    t.boolean "military_status", default: false
    t.datetime "military_status_date"
    t.boolean "obs_status", default: false
    t.datetime "obs_status_date"
    t.string "obs_registered_program"
    t.boolean "registered", default: false
    t.bigint "high_school_type_id"
    t.bigint "language_id"
    t.bigint "student_disability_type_id"
    t.bigint "unit_id", null: false
    t.bigint "student_entrance_type_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["high_school_type_id"], name: "index_prospective_students_on_high_school_type_id"
    t.index ["language_id"], name: "index_prospective_students_on_language_id"
    t.index ["student_disability_type_id"], name: "index_prospective_students_on_student_disability_type_id"
    t.index ["student_entrance_type_id"], name: "index_prospective_students_on_student_entrance_type_id"
    t.index ["unit_id"], name: "index_prospective_students_on_unit_id"
  end

  create_table "registration_documents", force: :cascade do |t|
    t.bigint "unit_id", null: false
    t.bigint "document_id", null: false
    t.bigint "academic_term_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["academic_term_id"], name: "index_registration_documents_on_academic_term_id"
    t.index ["document_id"], name: "index_registration_documents_on_document_id"
    t.index ["unit_id"], name: "index_registration_documents_on_unit_id"
  end

  create_table "student_disability_types", force: :cascade do |t|
    t.string "name"
    t.integer "code"
  end

  create_table "student_drop_out_types", force: :cascade do |t|
    t.string "name"
    t.integer "code"
  end

  create_table "student_education_levels", force: :cascade do |t|
    t.string "name"
    t.integer "code"
  end

  create_table "student_entrance_point_types", force: :cascade do |t|
    t.string "name"
    t.integer "code"
  end

  create_table "student_entrance_types", force: :cascade do |t|
    t.string "name"
    t.integer "code"
  end

  create_table "student_grades", force: :cascade do |t|
    t.string "name"
    t.integer "code"
  end

  create_table "student_grading_systems", force: :cascade do |t|
    t.string "name"
    t.integer "code"
  end

  create_table "student_punishment_types", force: :cascade do |t|
    t.string "name"
    t.integer "code"
  end

  create_table "student_studentship_statuses", force: :cascade do |t|
    t.string "name"
    t.integer "code"
  end

  create_table "students", force: :cascade do |t|
    t.string "student_number"
    t.boolean "permanently_registered", default: false
    t.bigint "user_id", null: false
    t.bigint "unit_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["unit_id"], name: "index_students_on_unit_id"
    t.index ["user_id"], name: "index_students_on_user_id"
  end

  create_table "titles", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.string "branch"
  end

  create_table "unit_instruction_languages", force: :cascade do |t|
    t.string "name"
    t.integer "code"
  end

  create_table "unit_instruction_types", force: :cascade do |t|
    t.string "name"
    t.integer "code"
  end

  create_table "unit_statuses", force: :cascade do |t|
    t.string "name"
    t.integer "code"
  end

  create_table "unit_types", force: :cascade do |t|
    t.string "name"
    t.integer "code"
    t.integer "group"
  end

  create_table "units", force: :cascade do |t|
    t.string "name"
    t.integer "yoksis_id"
    t.integer "detsis_id"
    t.integer "osym_id"
    t.integer "foet_code"
    t.date "founded_at"
    t.integer "duration"
    t.string "ancestry"
    t.string "names_depth_cache"
    t.bigint "district_id", null: false
    t.bigint "unit_status_id", null: false
    t.bigint "unit_instruction_language_id"
    t.bigint "unit_instruction_type_id"
    t.bigint "university_type_id"
    t.bigint "unit_type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ancestry"], name: "index_units_on_ancestry"
    t.index ["district_id"], name: "index_units_on_district_id"
    t.index ["unit_instruction_language_id"], name: "index_units_on_unit_instruction_language_id"
    t.index ["unit_instruction_type_id"], name: "index_units_on_unit_instruction_type_id"
    t.index ["unit_status_id"], name: "index_units_on_unit_status_id"
    t.index ["unit_type_id"], name: "index_units_on_unit_type_id"
    t.index ["university_type_id"], name: "index_units_on_university_type_id"
  end

  create_table "university_types", force: :cascade do |t|
    t.string "name"
    t.integer "code"
  end

  create_table "users", force: :cascade do |t|
    t.string "id_number"
    t.string "email"
    t.string "encrypted_password", default: ""
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "password_changed_at", default: -> { "CURRENT_TIMESTAMP" }
    t.integer "failed_attempts", default: 0
    t.string "unlock_token"
    t.datetime "locked_at"
    t.string "slug"
    t.string "preferred_language", default: "tr"
    t.integer "articles_count", default: 0
    t.integer "projects_count", default: 0
    t.jsonb "profile_preferences"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["id_number"], name: "index_users_on_id_number", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "academic_calendars", "academic_terms"
  add_foreign_key "academic_calendars", "calendar_types"
  add_foreign_key "addresses", "districts"
  add_foreign_key "addresses", "users"
  add_foreign_key "agendas", "agenda_types"
  add_foreign_key "agendas", "units"
  add_foreign_key "articles", "users"
  add_foreign_key "available_course_groups", "available_courses"
  add_foreign_key "available_course_lecturers", "available_course_groups", column: "group_id"
  add_foreign_key "available_course_lecturers", "employees", column: "lecturer_id"
  add_foreign_key "available_courses", "academic_terms"
  add_foreign_key "available_courses", "courses"
  add_foreign_key "available_courses", "curriculums"
  add_foreign_key "calendar_events", "academic_calendars"
  add_foreign_key "calendar_events", "academic_terms"
  add_foreign_key "calendar_events", "calendar_titles"
  add_foreign_key "calendar_events", "calendar_types"
  add_foreign_key "calendar_title_types", "calendar_titles", column: "title_id"
  add_foreign_key "calendar_title_types", "calendar_types", column: "type_id"
  add_foreign_key "calendar_unit_types", "calendar_types"
  add_foreign_key "calendar_unit_types", "unit_types"
  add_foreign_key "calendar_units", "academic_calendars"
  add_foreign_key "calendar_units", "units"
  add_foreign_key "certifications", "users"
  add_foreign_key "cities", "countries"
  add_foreign_key "committee_decisions", "meeting_agendas"
  add_foreign_key "committee_meetings", "units"
  add_foreign_key "course_groups", "course_group_types"
  add_foreign_key "course_groups", "units"
  add_foreign_key "courses", "course_types"
  add_foreign_key "courses", "languages"
  add_foreign_key "courses", "units"
  add_foreign_key "curriculum_course_groups", "course_groups"
  add_foreign_key "curriculum_course_groups", "curriculum_semesters"
  add_foreign_key "curriculum_courses", "courses"
  add_foreign_key "curriculum_courses", "curriculum_course_groups"
  add_foreign_key "curriculum_courses", "curriculum_semesters"
  add_foreign_key "curriculum_programs", "curriculums"
  add_foreign_key "curriculum_programs", "units"
  add_foreign_key "curriculum_semesters", "curriculums"
  add_foreign_key "curriculums", "units"
  add_foreign_key "districts", "cities"
  add_foreign_key "duties", "employees"
  add_foreign_key "duties", "units"
  add_foreign_key "employees", "titles"
  add_foreign_key "employees", "users"
  add_foreign_key "group_courses", "course_groups"
  add_foreign_key "group_courses", "courses"
  add_foreign_key "identities", "students"
  add_foreign_key "identities", "users"
  add_foreign_key "meeting_agendas", "agendas"
  add_foreign_key "meeting_agendas", "committee_meetings"
  add_foreign_key "positions", "administrative_functions"
  add_foreign_key "positions", "duties"
  add_foreign_key "projects", "users"
  add_foreign_key "prospective_students", "high_school_types"
  add_foreign_key "prospective_students", "languages"
  add_foreign_key "prospective_students", "student_disability_types"
  add_foreign_key "prospective_students", "student_entrance_types"
  add_foreign_key "prospective_students", "units"
  add_foreign_key "registration_documents", "academic_terms"
  add_foreign_key "registration_documents", "documents"
  add_foreign_key "registration_documents", "units"
  add_foreign_key "students", "units"
  add_foreign_key "students", "users"
  add_foreign_key "units", "districts"
  add_foreign_key "units", "unit_instruction_languages"
  add_foreign_key "units", "unit_instruction_types"
  add_foreign_key "units", "unit_statuses"
  add_foreign_key "units", "unit_types"
  add_foreign_key "units", "university_types"
end
