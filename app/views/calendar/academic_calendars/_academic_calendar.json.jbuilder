# frozen_string_literal: true

json.extract! academic_calendar,
              :id, :name, :academic_term_id, :calendar_type_id, :senate_decision_date,
              :senate_decision_no, :description, :created_at, :updated_at
json.url academic_calendar_url(academic_calendar, format: :json)
