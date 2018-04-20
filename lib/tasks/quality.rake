# frozen_string_literal: true

namespace :quality do
  desc 'Runs Ruby specific code quality testing'
  task :ruby do
    sh 'bundle exec rubocop -f fu -D'
    sh 'bundle exec reek'
    sh 'bundle exec rubycritic --format console'
  end

  desc 'Runs Rails specific code quality testing'
  task :rails do
    sh 'bundle exec rubocop -f fu -R -D'
  end

  desc 'Runs both rubocop and reek'
  task all: %w[ruby rails]
end
