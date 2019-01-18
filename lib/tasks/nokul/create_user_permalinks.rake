# frozen_string_literal: true

namespace :nokul do
  task create_user_permalinks: :environment do
    User.all.each(&:save!)
  end
end
