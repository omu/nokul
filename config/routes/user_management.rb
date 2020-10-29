# frozen_string_literal: true

scope module: :user_management do
  resources :users, except: %i[new create] do
    member do
      get 'save_address_from_mernis'
      get 'save_identity_from_mernis'

      get 'disability', to: 'disability#edit'
      put 'disability', to: 'disability#update'
    end

    collection do
      get 'employees', to: 'employees#index'
    end

    resources :employees, except: %i[index show]
    resources :duties,    except: %i[index show]
    resources :positions, except: %i[index show]
  end
end
