# frozen_string_literal: true

scope module: :account do
  resources :identities, except: [:show] do
    get 'save_from_mernis', on: :collection
  end
  resources :addresses, except: :show do
    get 'save_from_mernis', on: :collection
  end

  get '/profile', to: 'profile#edit'
  post '/profile', to: 'profile#update'
end
