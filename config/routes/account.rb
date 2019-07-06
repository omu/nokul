# frozen_string_literal: true

devise_for :users, controllers: {
  registrations: 'account/registrations',
  passwords:     'account/passwords',
  sessions:      'account/sessions',
  unlocks:       'account/unlocks'
}

devise_scope :user do
  scope module: :account do
    get 'account', to: 'registrations#edit'
    put 'phone_verification', to: 'registrations#phone_verification'
    post 'update_mobile_phone', to: 'registrations#update_mobile_phone'
    get 'login', to: 'sessions#new'
    get 'recover', to: 'passwords#new'
    delete 'logout', to: 'sessions#destroy'
  end
end

scope module: :account do
  get 'activation', to: 'activations#new'
  post 'activation', to: 'activations#create'
  post 'activation_phone_verification', to: 'activations#check_phone_verification'
  get '/profile', to: 'profile_settings#edit'
  patch '/profile', to: 'profile_settings#update'
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
