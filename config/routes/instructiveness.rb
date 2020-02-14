# frozen_string_literal: true

scope module: :instructiveness do
  resources :given_courses, only: %i[index show] do
    resources :assessments, only: [] do
      resources :grades, only: [] do
        collection do
          get :edit
          post :update
        end
      end
    end

    get :students, on: :member
  end
end
