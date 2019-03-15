# filter sensitive parameters from logs

Rails.application.config.filter_parameters += %i(
  client_id
  credit_card
  password
  password_confirmation
  store_key
)
