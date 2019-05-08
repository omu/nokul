# frozen_string_literal: true

namespace :patron do
  resources :assignments do
    collection do
      get :roles
      get :query_stores
    end
    get :preview_scope, on: :member
  end
  resources :permissions, only: %i[index show]
  resources :query_stores do
    get :preview, on: :member
  end
  resources :roles

  get '/', to: 'dashboard#index'
end
