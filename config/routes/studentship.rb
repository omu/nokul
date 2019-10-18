# frozen_string_literal: true

scope module: :studentship do
  resources :course_enrollments, only: %i[index new]
end
