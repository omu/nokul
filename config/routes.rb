# frozen_string_literal: true

Rails.application.routes.draw do
  require 'sidekiq/web'

  root to: 'home#index'

  # devise routes
  devise_for :users, controllers: {
    registrations: 'user/registrations',
    passwords: 'user/passwords',
    sessions: 'user/sessions'
  }

  # TODO: will add authorization when ready
  authenticate :user do
    mount Sidekiq::Web => '/sidekiq'
  end

  # Account home page
  scope module: :account do
    resources :identities, except: [:show] do
      get 'mernis', on: :member
    end
    resources :addresses, except: :show do
      get 'mernis', on: :member
    end
  end

  # Academic calendars
  scope module: :calendar do
    resources :academic_calendars
    resources :academic_terms, except: :show
    resources :calendar_titles, except: :show
    resources :calendar_types
  end

  resources :units

  scope module: :curriculum do
    resources :courses
  end

  scope module: :locations do
    resources :countries do
      resources :cities do
        resources :districts do
        end
      end
    end
  end

  scope module: :reference do
    resources :student_disability_types
    resources :student_drop_out_types
    resources :student_education_levels
    resources :student_entrance_point_types
    resources :student_entrance_types
    resources :student_grades
    resources :student_grading_systems
    resources :student_punishment_types
    resources :student_studentship_statuses
    resources :unit_instruction_languages
    resources :unit_instruction_types
    resources :unit_statuses
    resources :unit_types
    resources :university_types
  end
end
