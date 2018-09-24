scope module: :references do
  resources :countries do
    resources :cities, except: [:index] do
      resources :districts, except: [:show, :index] do
      end
    end
  end
  resources :languages, except: :show
end
