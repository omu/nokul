# frozen_string_literal: true

scope module: :outcome_management do
  resources :accreditation_standards do
    resources :outcomes, except: :index

    get :units, on: :collection
  end
end
