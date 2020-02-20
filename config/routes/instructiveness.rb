# frozen_string_literal: true

scope module: :instructiveness do
  resources :given_courses, only: %i[index show] do
    get :students, on: :member
  end
end
