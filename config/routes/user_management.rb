# frozen_string_literal: true

scope module: :user_management do
  resources :users do
    resources :identities do
      get :save_from_mernis, on: :collection
    end
  end
end
