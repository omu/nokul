# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'home#index'

  draw :account
  draw :admin
  draw :calendar_management
  draw :first_registration

  draw :course_management
  draw :references

  resources :units do
    member do
      get :courses, defaults: { format: :json }
      get :programs, defaults: { format: :json }
      get :curriculums, defaults: { format: :json }
      get :employees, default: { format: :json }
    end
  end

  resources :users, except: [:new, :create] do
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
