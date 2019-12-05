# frozen_string_literal: true

resources :students, only: [] do
  scope module: :studentship do
    resources :course_enrollments, except: %i[show update] do
      get :save, on: :collection
      get :list, on: :collection
    end
  end
end
