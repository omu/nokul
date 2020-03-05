# frozen_string_literal: true

Rails.application.routes.draw do
  require 'sidekiq/web'
  require 'sidekiq/cron/web'

  authenticate :user do
    mount Sidekiq::Web, at: 'sidekiq'
    mount PgHero::Engine, at: 'postgres'
  end

  get '/service-worker.js', to: 'service_workers/workers#index'
  get '/manifest.json', to: 'service_workers/manifests#index'
  root to: 'home#index'

  get :switch_account, to: 'application#switch_account'

  draw :account
  draw :calendar_management
  draw :course_management
  draw :detsis
  draw :first_registration
  draw :instructiveness
  draw :location
  draw :manager
  draw :meksis
  draw :patron
  draw :reference
  draw :studentship
  draw :tuition_management
  draw :user_management
  draw :yoksis
  draw :meksis
  draw :standard

  resources :students, only: %i[edit update]

  resources :units do
    member do
      get :courses, defaults: { format: :json }
      get :programs, defaults: { format: :json }
      get :curriculums, defaults: { format: :json }
      get :employees, default: { format: :json }
    end
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

  resources :ldap_entities do
    get :start_sync, on: :member
  end
end
