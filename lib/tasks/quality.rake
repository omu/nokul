# frozen_string_literal: true

namespace :quality do
  desc 'Runs Rails specific code quality testing'
  task :rails do
    sh 'bundle exec rubocop -f fu -R -D'
  end
end
