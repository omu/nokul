# frozen_string_literal: true

# Bullet is very strict about the Rails version. Temporarily disabled for Rails 6.0.0.beta1
# TODO: Enable after merging bullet upgrades.

# if Rails.env.development?
#   Rails.application.configure do
#     config.after_initialize do
#       Bullet.enable = true
#       Bullet.alert = true
#       Bullet.bullet_logger = true
#     end
#   end
# end
