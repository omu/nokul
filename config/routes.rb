# frozen_string_literal: true

Rails.application.routes.draw do
  require 'sidekiq/web'

  root to: 'home#index'

  # devise routes
  devise_for :users, path_prefix: 'devise', controllers: {
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
      get 'save_from_mernis', on: :collection
    end
    resources :addresses, except: :show do
      get 'save_from_mernis', on: :collection
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
      resources :cities, except: [:index] do
        resources :districts, except: [:show, :index] do
        end
      end
    end
  end

  resources :users do
    scope module: :account do
      resources :employees, except: :index do
        resources :duties, except: :index do
          resources :positions, except: %i[index show]
        end
      end
    end
  end

  scope module: :account do
    get '/profile', to: 'profile#edit'
    post '/profile', to: 'profile#update'
  end

  # public profiles
  get '/profiles/:id', to: 'public_profile#show'
  get '/profiles/:id/vcard',  to: 'public_profile#vcard', as: :profile_vcard

  scope module: :references do
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

  scope module: :studies do
    get '/studies', to: 'dashboard#index'
    get '/studies/articles', to: 'articles#index'
    get '/studies/projects', to: 'projects#index'
    get '/studies/certifications', to: 'certifications#index'
  end
end
