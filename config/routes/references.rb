# frozen_string_literal: true

scope module: :references do
  resources :terms, except: :show
  resources :academic_terms, except: :show
end
