# frozen_string_literal: true

Rails.application.routes.draw do
  require 'sidekiq/web'
  authenticate :user do
    mount Sidekiq::Web => '/sidekiq'
  end

  root to: 'home#index'

  draw :devise
  draw :account
  draw :calendar
  draw :references
  draw :yoksis_references

  resources :units do
    resources :registration_documents
    member do
      get :courses, defaults: { format: :json }
      get :programs, defaults: { format: :json }
    end
  end

  resources :documents

  scope module: :course_management do
    resources :courses
    resources :course_unit_groups
    resources :course_group_types, except: :show
    resources :curriculums
  end

  scope module: :student_management do
    resources :prospective_students, only: %i[index show] do
      get 'register', on: :member
    end
  end

  resources :users do
    get 'save_address_from_mernis', on: :member
    get 'save_identity_from_mernis', on: :member
  end

  # public profiles
  get '/profiles', to: 'public_profile#index'
  get '/profiles/:id', to: 'public_profile#show', as: :profiles_show
  get '/profiles/:id/vcard',  to: 'public_profile#vcard', as: :profile_vcard

  scope module: :studies do
    get '/studies', to: 'dashboard#index'
    get '/studies/articles', to: 'articles#index'
    get '/studies/projects', to: 'projects#index'
    get '/studies/certifications', to: 'certifications#index'
  end

  resources :agenda_types, except: :show, module: :committee

  resources :committees, only: :index, controller: 'committee/dashboard' do
    scope module: :committee do
      resources :agendas, except: :show
      resources :meetings
      resources :meeting_agendas, only: [] do
        resources :decisions, except: %i[index destroy]
      end
    end
  end
end
