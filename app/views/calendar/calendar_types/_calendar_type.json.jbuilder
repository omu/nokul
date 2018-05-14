# frozen_string_literal: true

json.extract! calendar_type, :id, :name, :created_at, :updated_at
json.url calendar_type_url(calendar_type, format: :json)
