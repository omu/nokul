# frozen_string_literal: true

namespace :first_registration do
  resources :registration_documents, except: :show
  resources :prospective_students, only: %i[index show] do
    get 'register', on: :member
  end
end
