# frozen_string_literal: true

namespace :calendar_management do
  resources :calendar_event_types
  resources :calendars do
    get 'duplicate'
  end

  resources :academic_terms, except: :show # TODO: which actions?
  # resources :unit_calendars
end
