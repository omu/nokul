# frozen_string_literal: true

namespace :post_deploy do
  task generate_permalinks_for_users: :environment do
    User.all.each(&:save!)
  end
end
