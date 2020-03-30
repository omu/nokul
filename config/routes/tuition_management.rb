# frozen_string_literal: true

scope module: :tuition_management do
  resources :tuitions, except: :show do
    get :units, on: :collection
  end
  resources :tuition_debts, only: %i[index new destroy] do
    post :create_with_service, on: :collection
  end
end
