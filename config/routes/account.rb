# frozen_string_literal: true

devise_for :users, controllers: {
  registrations: 'account/registrations',
  passwords:     'account/passwords',
  sessions:      'account/sessions',
  unlocks:       'account/unlocks'
}

devise_scope :user do
  get 'account', to: 'account/registrations#edit'
  get 'login', to: 'account/sessions#new'
  get 'recover', to: 'account/passwords#new'
  delete 'logout', to: 'account/sessions#destroy'
end

scope module: :account do
  get 'activation', to: 'activations#new'
  post 'activation', to: 'activations#create'
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
