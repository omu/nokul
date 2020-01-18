# frozen_string_literal: true

namespace :standard do
  get '/', to: 'dashboard#index'

  resources :sncc do
    resources :iccs
  end

end
