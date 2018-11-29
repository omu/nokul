# frozen_string_literal: true

scope module: :course_management do
  resources :courses
  resources :course_group_types, except: :show
  resources :course_types,       except: :show
  resources :course_unit_groups
  resources :curriculums

  resources :curriculum_semesters do
    resources :curriculum_semester_courses
  end
end
