# frozen_string_literal: true

require 'sidekiq/web'

authenticate :user do
  mount Sidekiq::Web, at: 'sidekiq'
  mount PgHero::Engine, at: 'postgres'
end
