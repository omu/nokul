# frozen_string_literal: true

# Be sure to restart your server when you modify this file.

# Configure sensitive parameters which will be filtered from the log file.
Rails.application.config.filter_parameters += %i[
  date_of_birth
  email
  fathers_name
  id_number
  mothers_name
  password
  place_of_birth
  registered_to
  registration_city
  registration_district
]
