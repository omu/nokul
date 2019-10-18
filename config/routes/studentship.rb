# frozen_string_literal: true

scope module: :studentship do
  resources :course_enrollments, except: %i[show update]
end
