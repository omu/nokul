# frozen_string_literal: true

scope module: :outcome_management do
  resources :unit_standards do
    resources :outcomes, except: :index
  end
end
