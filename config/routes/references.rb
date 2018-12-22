# frozen_string_literal: true

scope module: :references do
  resources :terms, except: :show
end
