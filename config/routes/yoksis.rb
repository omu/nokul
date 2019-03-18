# frozen_string_literal: true

namespace :yoksis do
  get '/', to: 'dashboard#index'
  resources :administrative_functions, except: :show
  resources :student_disability_types, except: :show
  resources :student_drop_out_types, except: :show
  resources :student_education_levels, except: :show
  resources :student_entrance_point_types, except: :show
  resources :student_entrance_types, except: :show
  resources :student_grades, except: :show
  resources :student_grading_systems, except: :show
  resources :student_punishment_types, except: :show
  resources :student_studentship_statuses, except: :show
  resources :unit_instruction_languages, except: :show
  resources :unit_instruction_types, except: :show
  resources :unit_statuses, except: :show
  resources :unit_types, except: :show
  resources :university_types, except: :show
end
