# frozen_string_literal: true

module MembershipNotificationsHelper
  def profile_completion_rate(user)
    i = 0
    i += 1 if user.identities.any?
    i += 1 if user.addresses.any?
    100 * i / 2
  end

  def password_change_progress_bar(user)
    last_password_change(user) * 100
  end

  def last_password_change(user)
    (Time.zone.now - user.password_changed_at) / 1.month.to_i
  end
end
