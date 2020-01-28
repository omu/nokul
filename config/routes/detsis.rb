# frozen_string_literal: true

namespace :detsis do
  root to: 'dashboard#index'

  resources :sdp_codes, only: %i[index]
end
