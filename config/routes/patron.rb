# frozen_string_literal: true

namespace :patron do
  root to: 'dashboard#index'
  resources :assignments do
    collection do
      get :roles
      get :query_stores
    end
    get :preview_scope, on: :member
  end
  resources :confirmations, only: %i[new create]
  resources :permissions, only: %i[index show]
  resources :roles
  resources :query_stores do
    member do
      get :preview
      post :preview
    end
  end
end
