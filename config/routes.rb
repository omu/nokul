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

  resources :units do
    member do
      get :courses, defaults: { format: :json }
      get :programs, defaults: { format: :json }
    end
  end

  resources :documents

  resources :units do
    resources :registration_documents
  end

  scope module: :course_management do
    resources :courses
    resources :course_unit_groups
    resources :course_group_types, except: :show
    resources :curriculums
  end

  scope module: :student_management do
    resources :prospective_students
  end

  draw :references
  draw :yoksis_references

  resources :users do
    get 'save_address_from_mernis', on: :member
    get 'save_identity_from_mernis', on: :member
    scope module: :account do
      resources :employees, except: %i[index show]
      resources :duties, except: %i[index show]
      resources :positions, except: %i[index show]
    end
  end

  scope module: :account do
    get '/profile', to: 'profile#edit'
    post '/profile', to: 'profile#update'
  end

  # public profiles
  get '/profiles/:id', to: 'public_profile#show'
  get '/profiles/:id/vcard',  to: 'public_profile#vcard', as: :profile_vcard

  scope module: :studies do
    get '/studies', to: 'dashboard#index'
    get '/studies/articles', to: 'articles#index'
    get '/studies/projects', to: 'projects#index'
    get '/studies/certifications', to: 'certifications#index'
  end

  resources :agenda_types, except: :show, module: :committee

  resources :committees, only: %i[index show], controller: 'committee/dashboard' do
    resources :agendas, except: :show, module: :committee
  end
end
