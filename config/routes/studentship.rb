# frozen_string_literal: true

resources :students, only: [] do
  scope module: :studentship do
    resources :course_enrollments, except: %i[show update] do
      get :save, on: :collection
      get :list, on: :collection
    end
    resources :tuition_debts, only: :index
  end
end
