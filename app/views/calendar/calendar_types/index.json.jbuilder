# frozen_string_literal: true

json.array! @calendar_types, partial: 'calendar/calendar_types/calendar_type', as: :calendar_type
