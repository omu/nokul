# frozen_string_literal: true

scope module: :references do
  resources :languages, except: :show
  resources :terms, except: :show
end
