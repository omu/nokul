# frozen_string_literal: true

scope module: :references do
  get 'references', to: 'home#index'
  resources :languages, except: :show
  resources :terms, except: :show
end
