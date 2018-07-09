# frozen_string_literal: true

module MembershipNotificationsHelper
  def profile_completion_rate(user)
    i = 0
    i += 1 if user.identities.any?
    i += 1 if user.addresses.any?
    100 * i / 2
  end

  def password_change_progress_bar(user)
    seconds_in_a_month = 30*24*60*60
    last_password_change = Time.zone.now - user.password_changed_at

    last_password_change * 100 / seconds_in_a_month
  end
end
