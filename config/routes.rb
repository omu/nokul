# frozen_string_literal: true

Rails.application.routes.draw do
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
end
