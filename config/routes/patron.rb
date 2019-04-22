# frozen_string_literal: true

namespace :patron do
  resources :roles
  resources :permissions, only: %i[index show]
  resources :query_stores do
    get :preview, on: :member
  end

  get '/', to: 'dashboard#index'
end
