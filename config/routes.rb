# frozen_string_literal: true

Rails.application.routes.draw do
  require 'sidekiq/web'

  root to: 'home#index'

  # devise routes
  devise_for :users, controllers: {
    registrations: 'user/registrations',
    passwords: 'user/passwords',
    sessions: 'user/sessions'
  }

  devise_scope :user do
    get 'register', to: 'devise/registrations#new'
    get 'login', to: 'devise/sessions#new'
    get 'update', to: 'devise/registrations#edit'
    get 'logout', to: 'devise/sessions#destroy'
    get 'recover', to: 'devise/passwords#new'
  end

  # TODO: will add authorization when ready
  authenticate :user do
    mount Sidekiq::Web => '/sidekiq'
  end

  # Account home page
  scope module: :account do
    get 'account', to: 'home#index'
    resources :identities, except: [:show] do
      get 'mernis', to: 'identities#update_from_mernis'
    end
    resources :addresses, except: :show do
      get 'mernis', to: 'addresses#update_from_mernis'
    end
  end

  # Academic calendars
  scope module: :calendar do
    resources :academic_calendars
    resources :academic_terms, except: :show
    resources :calendar_titles, except: :show
    resources :calendar_types
  end
end
