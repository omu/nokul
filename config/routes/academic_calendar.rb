# frozen_string_literal: true

namespace :calendar_management do
  resources :calendar_event_types
  
  resources :calendars # TODO: which actions?
  resources :academic_terms, except: :show # TODO: which actions?
  # resources :unit_calendars
end
