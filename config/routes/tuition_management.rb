# frozen_string_literal: true

scope module: :tuition_management do
  resources :tuitions do
    get :units, on: :collection
  end
end
