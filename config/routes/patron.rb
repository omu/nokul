# frozen_string_literal: true

namespace :patron do
  resources :assignments do
    collection do
      get :roles
      get :query_stores
    end
  end
  resources :permissions, only: %i[index show]
  resources :query_stores do
    get :preview, on: :member
  end
  resources :roles

  get '/', to: 'dashboard#index'
end
