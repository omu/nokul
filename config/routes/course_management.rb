# frozen_string_literal: true

scope module: :course_management do
  resources :available_courses do
    resources :available_course_groups, except: :index
  end

  resources :courses
  resources :course_unit_groups
  resources :course_group_types, except: :show
  resources :curriculums do
    member do
      get :courses, defaults: { format: :json }
    end
  end

  resources :curriculum_semesters do
    resources :curriculum_semester_courses
  end
end
