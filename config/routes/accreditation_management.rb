# frozen_string_literal: true

scope module: :accreditation_management do
  resources :accreditation_standards do
    resources :learning_outcomes, except: :index

    get :units, on: :collection
  end
end
