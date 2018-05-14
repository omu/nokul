# frozen_string_literal: true

json.extract! academic_term, :id, :name, :created_at, :updated_at
json.url academic_term_url(academic_term, format: :json)
