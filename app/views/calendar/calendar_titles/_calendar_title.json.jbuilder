# frozen_string_literal: true

json.extract! calendar_title, :id, :name, :created_at, :updated_at
json.url calendar_title_url(calendar_title, format: :json)
