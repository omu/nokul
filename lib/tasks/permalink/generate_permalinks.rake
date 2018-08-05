# frozen_string_literal: true

task generate_permalinks_for_users: :environment do
  User.all.each(&:save!)
end
