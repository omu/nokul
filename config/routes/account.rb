# frozen_string_literal: true

devise_for :users, skip: :registrations, controllers: {
  passwords:          'account/passwords',
  sessions:           'account/sessions',
  unlocks:            'account/unlocks',
  omniauth_callbacks: 'account/omniauth_callbacks'
}

devise_scope :user do
  scope module: :account do
    get 'login', to: 'sessions#new'
    get 'recover', to: 'passwords#new'
    delete 'logout', to: 'sessions#destroy'
    get 'logout', to: 'sessions#destroy'
  end
end

scope module: :account do
  namespace :settings do
    get '/', action: :index
    scope module: :emails do
      get 'emails', action: :edit
      put 'emails', action: :update
    end
    scope module: :passwords do
      get 'passwords', action: :edit
      put 'passwords', action: :update
    end
    scope module: :phones do
      get 'phones', action: :edit
      put 'phone_verification', action: :verification
      post 'phones', action: :update
    end
    namespace :preferences do
      get 'profile', to: 'profiles#edit'
      patch 'profile', to: 'profiles#update'
    end
  end

  get 'activation',                     to: 'activations#new'
  post 'activation',                    to: 'activations#create'
  post 'activation_phone_verification', to: 'activations#check_phone_verification'
  get 'yoksis_services/fetch',          to: 'yoksis_services#fetch'

  get 'password_recovery',         to: 'password_recovery#new'
  post 'password_recovery',        to: 'password_recovery#create'
  get 'password_recovery/update',  to: 'password_recovery#edit'
  post 'password_recovery/update', to: 'password_recovery#update'
end

resources :users, only: [] do
  scope module: :account, controller: :profile, as: 'profile' do
    get :edit
    get :courses
    get :articles
    get :books
    get :certifications
    get :papers
    get :projects
  end
  scope module: :account do
    get 'profile',                        to: 'profile#index'
    patch 'profile',                      to: 'profile#update'
    resources :identities, except: [:show] do
      get 'save_from_mernis', on: :collection
    end
    resources :addresses, except: :show do
      get 'save_from_mernis', on: :collection
    end
  end
end
