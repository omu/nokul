# frozen_string_literal: true

json.array! @academic_calendars, partial: 'calendar/academic_calendars/academic_calendar', as: :academic_calendar
