# frozen_string_literal: true

devise_for :users, controllers: {
  registrations: 'account/registrations',
  passwords: 'account/passwords',
  sessions: 'account/sessions',
  unlocks: 'account/unlocks'
}

devise_scope :user do
  get 'account', to: 'account/registrations#edit'
  get 'login', to: 'account/sessions#new'
  get 'register', to: 'account/registrations#new'
  get 'recover', to: 'account/passwords#new'
  delete 'logout', to: 'account/sessions#destroy'
end

scope module: :account do
  get '/profile', to: 'profile_settings#edit'
  post '/profile', to: 'profile_settings#update'

  resources :identities, except: :show do
    get 'save_from_mernis', on: :collection
  end
  resources :addresses, except: :show do
    get 'save_from_mernis', on: :collection
  end
end
