# frozen_string_literal: true

scope module: :references do
  resources :academic_terms, except: :show
  resources :terms, except: :show
end
