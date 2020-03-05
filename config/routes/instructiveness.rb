# frozen_string_literal: true

scope module: :instructiveness do
  resources :given_courses, only: %i[index show] do
    resources :assessments, only: %i[show edit update] do
      member do
        get :save
        get :draft
      end
    end

    get :students, on: :member
  end
end
