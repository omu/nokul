# frozen_string_literal: true

scope module: :calendar do
  resources :academic_calendars
  resources :academic_terms, except: :show
  resources :calendar_titles, only: %i[index edit update]
  resources :calendar_types
end
