# frozen_string_literal: true

require 'rails/test_unit/runner'

namespace :test do
  task foo: :environment do
    $LOAD_PATH << '../../../../tenant/test'
    Rails::TestUnit::Runner.rake_run
  end
end
