# frozen_string_literal: true

namespace :user_management do
  resources :users do
    resources :identities, except: [:show] do
      get 'save_from_mernis', on: :collection
    end
    resources :addresses, except: :show do
      get 'save_from_mernis', on: :collection
    end

    resources :employees, except: %i[index show]
    resources :students, except: %i[index show]
    resources :duties, except: %i[index show]
    resources :positions, except: %i[index show]

    get 'save_address_from_mernis', on: :member
    get 'save_identity_from_mernis', on: :member
  end
end
