# frozen_string_literal: true

namespace :nokul do
  desc 'Update counter cache for number of articles a user have'
  task update_article_counter: :environment do
    User.find_each { |user| User.reset_counters(user.id, :articles) }
  end

  desc 'Update counter cache for number of projects a user have'
  task update_project_counter: :environment do
    User.find_each { |user| User.reset_counters(user.id, :projects) }
  end

  desc 'Run all counter cache update tasks'
  task all: %w[update_article_counter update_project_counter]
end
