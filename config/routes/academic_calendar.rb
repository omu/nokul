# frozen_string_literal: true

namespace :academic_calendar
  resources :calendars # TODO: which actions?
  resources :calendar_event_types # TODO: which actions?
  resources :academic_terms, except: :show # TODO: which actions?
  # resources :unit_calendars
end
