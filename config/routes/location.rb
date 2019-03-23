# frozen_string_literal: true

scope module: :location do
  resources :countries do
    resources :cities, except: [:index] do
      resources :districts, except: %i[show index] do
      end
    end
  end
end
