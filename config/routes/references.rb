# frozen_string_literal: true

scope module: :references do
  get 'references', to: 'home#index'
  resources :countries do
    resources :cities, except: [:index] do
      resources :districts, except: %i[show index] do
      end
    end
  end
  resources :languages, except: :show
  resources :terms, except: :show
end
