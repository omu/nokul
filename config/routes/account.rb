# frozen_string_literal: true

devise_for :users, skip: :registrations, controllers: {
  passwords: 'account/passwords',
  sessions:  'account/sessions',
  unlocks:   'account/unlocks'
}

devise_scope :user do
  scope module: :account do
    get 'login', to: 'sessions#new'
    get 'recover', to: 'passwords#new'
    delete 'logout', to: 'sessions#destroy'
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
  end
  get 'activation', to: 'activations#new'
  post 'activation', to: 'activations#create'
  post 'activation_phone_verification', to: 'activations#check_phone_verification'
  get '/profile/edit', to: 'profiles#edit'
  get '/profile', to: 'profiles#show'
  patch '/profile', to: 'profiles#update'
end

resources :users, only: [] do
  scope module: :account do
    resources :identities, except: [:show] do
      get 'save_from_mernis', on: :collection
    end
    resources :addresses, except: :show do
      get 'save_from_mernis', on: :collection
    end

    resources :employees, except: %i[index show]
    resources :duties, except: %i[index show]
    resources :positions, except: %i[index show]
  end
end
