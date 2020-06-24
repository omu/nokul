# frozen_string_literal: true

Rails.application.configure do
  config.after_initialize do
    Extensions::Regulation::Loader.call unless Rails.env.production?
  end
end
