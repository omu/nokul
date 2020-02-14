# frozen_string_literal: true

scope module: :instructiveness do
  resources :given_courses, only: %i[index show] do
    resources :assessments, only: [] do
      resources :grades, only: [] do
        get :edit, on: :collection
        post :update, on: :collection
      end
    end

    get :students, on: :member
  end
end
