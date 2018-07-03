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

  # TODO: will add authorization when ready
  authenticate :user do
    mount Sidekiq::Web => '/sidekiq'
  end

  # Account home page
  scope module: :account do
    resources :identities, except: [:show] do
      get 'mernis', on: :member
    end
    resources :addresses, except: :show do
      get 'mernis', on: :member
    end
  end

  # Academic calendars
  scope module: :calendar do
    resources :academic_calendars
    resources :academic_terms, except: :show
    resources :calendar_titles, except: :show
    resources :calendar_types
  end

  resources :units

  scope module: :curriculum do
    resources :courses
  end

  scope module: :locations do
    resources :countries do
      resources :cities do
        resources :districts do
        end
      end
    end
  end

  scope module: :references do
    resources :unit_instruction_languages
    resources :unit_instruction_types
    resources :unit_statuses
    resources :unit_types
    resources :university_types
  end
end
