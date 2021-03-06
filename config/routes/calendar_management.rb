# frozen_string_literal: true

scope module: :calendar_management do
  resources :calendar_event_types
  resources :calendars do
    member do
      get :duplicate
      get :units
    end
  end
end
