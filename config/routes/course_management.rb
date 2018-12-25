# frozen_string_literal: true

scope module: :course_management do
  resources :available_courses do
    resources :available_course_groups, except: :index
  end

  resources :courses
  resources :course_criterion_types, except: :show
  resources :course_groups
  resources :course_group_types, except: :show
  resources :course_types,       except: :show
  resources :course_unit_groups
  resources :curriculums do
    member do
      get :courses, defaults: { format: :json }
    end
  end

  resources :curriculum_semesters do
    resources :curriculum_courses, except: %i[index show]
    resources :curriculum_course_groups, except: %i[index show]
  end
end
