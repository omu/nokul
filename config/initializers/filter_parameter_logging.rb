# frozen_string_literal: true

Rails.application.config.filter_parameters += %i[
  access_token
  account_sid
  api_secret
  auth_token
  bearer_token
  client_id
  credit_card
  password
  password_confirmation
  secret_key
  store_key
]
