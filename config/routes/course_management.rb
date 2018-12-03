# frozen_string_literal: true

scope module: :course_management do
  resources :courses
  resources :course_groups
  resources :course_group_types, except: :show
  resources :course_types,       except: :show
  resources :curriculums

  resources :curriculum_semesters do
    resources :curriculum_courses, except: %i[index show]
    resources :curriculum_course_groups, except: %i[index show]
  end
end
