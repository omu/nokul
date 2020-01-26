# frozen_string_literal: true

namespace :detsis do
  get '/', to: 'dashboard#index'

  resources :sdp_codes, only: %i[index]
end
