# frozen_string_literal: true

scope module: :first_registration do
  resources :registration_documents, except: :show
  resources :prospective_employees, except: :show
  resources :prospective_students, except: :destroy do
    get :register, on: :member
    post :fetch,   on: :collection
  end
end
