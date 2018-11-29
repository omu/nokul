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

ActiveRecord::Schema.define(version: 2018_11_28_093908) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "academic_calendars", force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.date "senate_decision_date", null: false
    t.string "senate_decision_no", limit: 255, null: false
    t.text "description"
    t.bigint "academic_term_id"
    t.bigint "calendar_type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["academic_term_id"], name: "index_academic_calendars_on_academic_term_id"
    t.index ["calendar_type_id"], name: "index_academic_calendars_on_calendar_type_id"
  end

  create_table "academic_terms", force: :cascade do |t|
    t.string "year", limit: 255, null: false
    t.integer "term", limit: 2, null: false
    t.datetime "start_of_term"
    t.datetime "end_of_term"
    t.boolean "active", default: false
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", limit: 255, null: false
    t.string "filename", limit: 255, null: false
    t.string "content_type", limit: 255
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", limit: 255, null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "addresses", force: :cascade do |t|
    t.integer "type", null: false
    t.string "phone_number", limit: 255
    t.string "full_address", limit: 255, null: false
    t.bigint "district_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["district_id"], name: "index_addresses_on_district_id"
    t.index ["user_id"], name: "index_addresses_on_user_id"
  end

  create_table "administrative_functions", force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.integer "code", null: false
  end

  create_table "agenda_types", force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "agendas", force: :cascade do |t|
    t.text "description", null: false
    t.integer "status", default: 0, null: false
    t.bigint "unit_id"
    t.bigint "agenda_type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["agenda_type_id"], name: "index_agendas_on_agenda_type_id"
    t.index ["unit_id"], name: "index_agendas_on_unit_id"
  end

  create_table "articles", force: :cascade do |t|
    t.integer "yoksis_id", null: false
    t.integer "scope"
    t.integer "review"
    t.integer "index"
    t.text "title"
    t.text "authors"
    t.integer "number_of_authors"
    t.integer "country"
    t.string "city", limit: 255
    t.string "journal", limit: 255
    t.string "language_of_publication", limit: 255
    t.integer "month"
    t.integer "year"
    t.string "volume", limit: 255
    t.string "issue", limit: 255
    t.integer "first_page"
    t.integer "last_page"
    t.string "doi", limit: 255
    t.string "issn", limit: 255
    t.integer "access_type"
    t.text "access_link"
    t.text "discipline"
    t.string "keyword", limit: 255
    t.integer "special_issue"
    t.integer "special_issue_name"
    t.string "sponsored_by", limit: 255
    t.integer "author_id"
    t.datetime "last_update"
    t.integer "status"
    t.integer "type"
    t.float "incentive_point"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_articles_on_user_id"
  end

  create_table "available_course_groups", force: :cascade do |t|
    t.string "name", limit: 50, null: false
    t.integer "quota"
    t.bigint "available_course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["available_course_id"], name: "index_available_course_groups_on_available_course_id"
  end

  create_table "available_course_lecturers", force: :cascade do |t|
    t.boolean "coordinator", default: false, null: false
    t.bigint "group_id"
    t.bigint "lecturer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_available_course_lecturers_on_group_id"
    t.index ["lecturer_id"], name: "index_available_course_lecturers_on_lecturer_id"
  end

  create_table "available_courses", force: :cascade do |t|
    t.bigint "academic_term_id"
    t.bigint "curriculum_id"
    t.bigint "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["academic_term_id"], name: "index_available_courses_on_academic_term_id"
    t.index ["course_id"], name: "index_available_courses_on_course_id"
    t.index ["curriculum_id"], name: "index_available_courses_on_curriculum_id"
  end

  create_table "calendar_events", force: :cascade do |t|
    t.datetime "start_date", null: false
    t.datetime "end_date"
    t.bigint "academic_calendar_id"
    t.bigint "calendar_title_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "calendar_type_id"
    t.bigint "academic_term_id"
    t.index ["academic_calendar_id"], name: "index_calendar_events_on_academic_calendar_id"
    t.index ["academic_term_id"], name: "index_calendar_events_on_academic_term_id"
    t.index ["calendar_title_id"], name: "index_calendar_events_on_calendar_title_id"
    t.index ["calendar_type_id"], name: "index_calendar_events_on_calendar_type_id"
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
    t.string "name", limit: 255, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "calendar_types", force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "calendar_unit_types", force: :cascade do |t|
    t.bigint "calendar_type_id"
    t.bigint "unit_type_id"
    t.index ["calendar_type_id"], name: "index_calendar_unit_types_on_calendar_type_id"
    t.index ["unit_type_id"], name: "index_calendar_unit_types_on_unit_type_id"
  end

  create_table "calendar_units", force: :cascade do |t|
    t.bigint "academic_calendar_id"
    t.bigint "unit_id"
    t.index ["academic_calendar_id"], name: "index_calendar_units_on_academic_calendar_id"
    t.index ["unit_id"], name: "index_calendar_units_on_unit_id"
  end

  create_table "certifications", force: :cascade do |t|
    t.integer "yoksis_id", null: false
    t.integer "type", default: 1, null: false
    t.string "name", limit: 255
    t.text "content"
    t.string "location", limit: 255
    t.integer "scope"
    t.string "duration", limit: 255
    t.date "start_date"
    t.date "end_date"
    t.string "title", limit: 255
    t.integer "number_of_authors"
    t.string "city_and_country", limit: 255
    t.datetime "last_update"
    t.float "incentive_point"
    t.integer "status"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_certifications_on_user_id"
  end

  create_table "cities", force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.string "alpha_2_code", limit: 255, null: false
    t.bigint "country_id"
    t.index ["country_id"], name: "index_cities_on_country_id"
  end

  create_table "committee_decisions", force: :cascade do |t|
    t.text "description", null: false
    t.string "decision_no", limit: 255, null: false
    t.integer "year", null: false
    t.bigint "meeting_agenda_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["meeting_agenda_id"], name: "index_committee_decisions_on_meeting_agenda_id"
  end

  create_table "committee_meetings", force: :cascade do |t|
    t.integer "meeting_no", null: false
    t.date "meeting_date", null: false
    t.integer "year", null: false
    t.bigint "unit_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["unit_id"], name: "index_committee_meetings_on_unit_id"
  end

  create_table "countries", force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.string "alpha_2_code", limit: 255, null: false
    t.string "alpha_3_code", limit: 255, null: false
    t.string "numeric_code", limit: 255, null: false
    t.string "mernis_code", limit: 255
    t.integer "yoksis_code"
  end

  create_table "course_group_types", force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "course_types", force: :cascade do |t|
    t.string "name", limit: 255
    t.string "code", limit: 50
    t.decimal "min_credit", precision: 5, scale: 2, default: "0.0", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "course_unit_groups", force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.integer "total_ects_condition", null: false
    t.bigint "unit_id"
    t.bigint "course_group_type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_group_type_id"], name: "index_course_unit_groups_on_course_group_type_id"
    t.index ["unit_id"], name: "index_course_unit_groups_on_unit_id"
  end

  create_table "courses", force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.string "code", limit: 255, null: false
    t.integer "theoric", null: false
    t.integer "practice", null: false
    t.integer "laboratory", null: false
    t.decimal "credit", precision: 5, scale: 2, default: "0.0", null: false
    t.integer "program_type", null: false
    t.integer "status", null: false
    t.bigint "unit_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "language_id"
    t.bigint "course_type_id"
    t.index ["course_type_id"], name: "index_courses_on_course_type_id"
    t.index ["language_id"], name: "index_courses_on_language_id"
    t.index ["unit_id"], name: "index_courses_on_unit_id"
  end

  create_table "curriculum_programs", force: :cascade do |t|
    t.bigint "unit_id"
    t.bigint "curriculum_id"
    t.index ["curriculum_id"], name: "index_curriculum_programs_on_curriculum_id"
    t.index ["unit_id"], name: "index_curriculum_programs_on_unit_id"
  end

  create_table "curriculum_semester_courses", force: :cascade do |t|
    t.bigint "course_id"
    t.bigint "curriculum_semester_id"
    t.decimal "ects", precision: 5, scale: 2, default: "0.0", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_curriculum_semester_courses_on_course_id"
    t.index ["curriculum_semester_id"], name: "index_curriculum_semester_courses_on_curriculum_semester_id"
  end

  create_table "curriculum_semesters", force: :cascade do |t|
    t.integer "sequence"
    t.bigint "curriculum_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "year"
    t.index ["curriculum_id"], name: "index_curriculum_semesters_on_curriculum_id"
  end

  create_table "curriculums", force: :cascade do |t|
    t.string "name", limit: 255
    t.integer "semesters_count", default: 0
    t.integer "status", null: false
    t.bigint "unit_id"
    t.index ["unit_id"], name: "index_curriculums_on_unit_id"
  end

  create_table "districts", force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.string "mernis_code", limit: 255
    t.boolean "active", default: true, null: false
    t.bigint "city_id"
    t.index ["city_id"], name: "index_districts_on_city_id"
  end

  create_table "documents", force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.string "statement", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "duties", force: :cascade do |t|
    t.boolean "temporary", null: false
    t.date "start_date", null: false
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

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", limit: 255, null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope", limit: 255
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"
  end

  create_table "group_courses", force: :cascade do |t|
    t.bigint "course_id"
    t.bigint "course_unit_group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_group_courses_on_course_id"
    t.index ["course_unit_group_id"], name: "index_group_courses_on_course_unit_group_id"
  end

  create_table "high_school_types", force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.integer "code", null: false
  end

  create_table "identities", force: :cascade do |t|
    t.integer "type", null: false
    t.string "first_name", limit: 255, null: false
    t.string "last_name", limit: 255, null: false
    t.string "mothers_name", limit: 255
    t.string "fathers_name", limit: 255
    t.integer "gender", null: false
    t.integer "marital_status"
    t.string "place_of_birth", limit: 255, null: false
    t.date "date_of_birth", null: false
    t.string "registered_to", limit: 255
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.bigint "student_id"
    t.index ["student_id"], name: "index_identities_on_student_id"
    t.index ["user_id"], name: "index_identities_on_user_id"
  end

  create_table "languages", force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.string "iso", limit: 255, null: false
  end

  create_table "meeting_agendas", force: :cascade do |t|
    t.bigint "agenda_id"
    t.bigint "committee_meeting_id"
    t.integer "sequence_no", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["agenda_id"], name: "index_meeting_agendas_on_agenda_id"
    t.index ["committee_meeting_id"], name: "index_meeting_agendas_on_committee_meeting_id"
  end

  create_table "positions", force: :cascade do |t|
    t.date "start_date", null: false
    t.date "end_date"
    t.bigint "duty_id"
    t.bigint "administrative_function_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["administrative_function_id"], name: "index_positions_on_administrative_function_id"
    t.index ["duty_id"], name: "index_positions_on_duty_id"
  end

  create_table "projects", force: :cascade do |t|
    t.integer "yoksis_id", null: false
    t.text "name"
    t.text "subject"
    t.integer "status"
    t.date "start_date"
    t.date "end_date"
    t.string "budget", limit: 255
    t.string "duty", limit: 255
    t.string "type", limit: 255
    t.string "currency", limit: 255
    t.datetime "last_update"
    t.integer "activity"
    t.integer "scope"
    t.string "title", limit: 255
    t.integer "unit_id"
    t.float "incentive_point"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_projects_on_user_id"
  end

  create_table "prospective_students", force: :cascade do |t|
    t.string "id_number", limit: 255, null: false
    t.string "first_name", limit: 255, null: false
    t.string "last_name", limit: 255, null: false
    t.string "fathers_name", limit: 255
    t.string "mothers_name", limit: 255
    t.date "date_of_birth"
    t.integer "gender"
    t.integer "nationality"
    t.string "place_of_birth", limit: 255
    t.string "registration_city", limit: 255
    t.string "registration_district", limit: 255
    t.string "high_school_code", limit: 255
    t.bigint "high_school_type_id"
    t.string "high_school_branch", limit: 255
    t.integer "state_of_education"
    t.integer "high_school_graduation_year"
    t.integer "placement_type"
    t.float "exam_score"
    t.bigint "language_id"
    t.string "address", limit: 255
    t.string "home_phone", limit: 255
    t.string "mobile_phone", limit: 255
    t.string "email", limit: 255
    t.bigint "student_disability_type_id"
    t.boolean "top_student", default: false, null: false
    t.float "placement_score"
    t.integer "placement_rank"
    t.bigint "unit_id"
    t.integer "preference_order"
    t.string "placement_score_type", limit: 255
    t.integer "additional_score"
    t.boolean "meb_status", default: false, null: false
    t.datetime "meb_status_date"
    t.boolean "military_status", default: false, null: false
    t.datetime "military_status_date"
    t.boolean "obs_status", default: false, null: false
    t.datetime "obs_status_date"
    t.string "obs_registered_program", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "student_entrance_type_id"
    t.boolean "registered", default: false
    t.index ["high_school_type_id"], name: "index_prospective_students_on_high_school_type_id"
    t.index ["language_id"], name: "index_prospective_students_on_language_id"
    t.index ["student_disability_type_id"], name: "index_prospective_students_on_student_disability_type_id"
    t.index ["student_entrance_type_id"], name: "index_prospective_students_on_student_entrance_type_id"
    t.index ["unit_id"], name: "index_prospective_students_on_unit_id"
  end

  create_table "registration_documents", force: :cascade do |t|
    t.bigint "unit_id"
    t.bigint "document_id"
    t.bigint "academic_term_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["academic_term_id"], name: "index_registration_documents_on_academic_term_id"
    t.index ["document_id"], name: "index_registration_documents_on_document_id"
    t.index ["unit_id"], name: "index_registration_documents_on_unit_id"
  end

  create_table "student_disability_types", force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.integer "code", null: false
  end

  create_table "student_drop_out_types", force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.integer "code", null: false
  end

  create_table "student_education_levels", force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.integer "code", null: false
  end

  create_table "student_entrance_point_types", force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.integer "code", null: false
  end

  create_table "student_entrance_types", force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.integer "code", null: false
  end

  create_table "student_grades", force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.integer "code", null: false
  end

  create_table "student_grading_systems", force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.integer "code", null: false
  end

  create_table "student_punishment_types", force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.integer "code", null: false
  end

  create_table "student_studentship_statuses", force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.integer "code", null: false
  end

  create_table "students", force: :cascade do |t|
    t.string "student_number", limit: 255, null: false
    t.bigint "user_id"
    t.bigint "unit_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "permanently_registered", default: false, null: false
    t.index ["unit_id"], name: "index_students_on_unit_id"
    t.index ["user_id"], name: "index_students_on_user_id"
  end

  create_table "titles", force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.string "code", limit: 255, null: false
    t.string "branch", limit: 255, null: false
  end

  create_table "unit_instruction_languages", force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.integer "code", null: false
  end

  create_table "unit_instruction_types", force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.integer "code", null: false
  end

  create_table "unit_statuses", force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.integer "code", null: false
  end

  create_table "unit_types", force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.integer "code", null: false
    t.integer "group"
  end

  create_table "units", force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.integer "yoksis_id"
    t.integer "detsis_id"
    t.integer "foet_code"
    t.date "founded_at"
    t.integer "duration", limit: 2
    t.integer "osym_id"
    t.string "ancestry"
    t.bigint "district_id"
    t.bigint "unit_status_id"
    t.bigint "unit_instruction_language_id"
    t.bigint "unit_instruction_type_id"
    t.bigint "university_type_id"
    t.bigint "unit_type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "names_depth_cache", limit: 255
    t.index ["ancestry"], name: "index_units_on_ancestry"
    t.index ["district_id"], name: "index_units_on_district_id"
    t.index ["unit_instruction_language_id"], name: "index_units_on_unit_instruction_language_id"
    t.index ["unit_instruction_type_id"], name: "index_units_on_unit_instruction_type_id"
    t.index ["unit_status_id"], name: "index_units_on_unit_status_id"
    t.index ["unit_type_id"], name: "index_units_on_unit_type_id"
    t.index ["university_type_id"], name: "index_units_on_university_type_id"
  end

  create_table "university_types", force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.integer "code", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "id_number", limit: 255, null: false
    t.string "email", limit: 255, null: false
    t.string "encrypted_password", limit: 255, default: "", null: false
    t.string "reset_password_token", limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "password_changed_at", default: -> { "now()" }, null: false
    t.string "slug", limit: 255
    t.string "preferred_language", limit: 2, default: "tr"
    t.integer "articles_count", default: 0, null: false
    t.integer "projects_count", default: 0, null: false
    t.jsonb "profile_preferences"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["id_number"], name: "index_users_on_id_number", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "available_course_lecturers", "available_course_groups", column: "group_id"
  add_foreign_key "available_course_lecturers", "employees", column: "lecturer_id"
  add_foreign_key "calendar_events", "academic_terms"
  add_foreign_key "calendar_events", "calendar_types"
  add_foreign_key "calendar_title_types", "calendar_titles", column: "title_id"
  add_foreign_key "calendar_title_types", "calendar_types", column: "type_id"
  add_foreign_key "calendar_unit_types", "calendar_types"
  add_foreign_key "calendar_unit_types", "unit_types"
  add_foreign_key "calendar_units", "academic_calendars"
  add_foreign_key "calendar_units", "units"
  add_foreign_key "courses", "course_types"
  add_foreign_key "courses", "languages"
  add_foreign_key "curriculum_semester_courses", "courses"
  add_foreign_key "curriculum_semester_courses", "curriculum_semesters"
  add_foreign_key "curriculum_semesters", "curriculums"
end
