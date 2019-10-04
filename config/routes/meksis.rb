# frozen_string_literal: true

namespace :meksis do
  get '/', to: 'dashboard#index'

  resources :place_types
  resources :buildings do
    resources :classrooms
  end
end
