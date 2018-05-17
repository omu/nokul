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

  scope module: :calendar do
    resources :academic_calendars
    resources :academic_terms, except: :show
    resources :calendar_titles, except: :show
    resources :calendar_types
  end
end
