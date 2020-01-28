# frozen_string_literal: true

namespace :meksis do
 root to: 'dashboard#index'

  resources :place_types, only: %i[index show]
  resources :buildings, except: %i[new create destroy] do
    resources :classrooms, only: %i[index show]
  end
end
