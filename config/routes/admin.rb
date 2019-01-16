# frozen_string_literal: true

require 'sidekiq/web'

authenticate :user do
  mount Sidekiq::Web, at: 'sidekiq'
  mount PgHero::Engine, at: 'postgres'
end

# rubocop:disable Metrics/BlockLength
namespace :admin do
  # Location Management
  resources :countries do
    resources :cities, except: [:index] do
      resources :districts, except: %i[show index] do
      end
    end
  end

  # YOKSIS References
  get 'yoksis', to: 'yoksis_dashboard#index'
  resources :high_school_types, except: :show
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

  # Other References
  resources :document_types, except: :show
  resources :evaluation_types, except: :show
  resources :languages, except: :show
  resources :titles, except: :show
  # rubocop:enable Metrics/BlockLength
end
