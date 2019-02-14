# frozen_string_literal: true

scope module: :term_management do
  resources :academic_terms, except: :show
end
