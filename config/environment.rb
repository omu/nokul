# frozen_string_literal: true

# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

# If you need complete loading for some models, define them as methods and list below:
Unit.generate_scopes