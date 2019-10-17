# frozen_string_literal: true

scope module: :studentship do
  resources :course_enrolments, only: :index
end
