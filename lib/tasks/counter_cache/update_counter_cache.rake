# frozen_string_literal: true

namespace :update_counter_cache do
  desc 'Update counter cache for number of articles a user have'
  task article_counter: :environment do
    User.find_each { |user| User.reset_counters(user.id, :articles) }
  end

  desc 'Update counter cache for number of projects a user have'
  task project_counter: :environment do
    User.find_each { |user| User.reset_counters(user.id, :projects) }
  end

  desc 'Runs all counter cache update tasks'
  task all: %w[article_counter project_counter]
end
