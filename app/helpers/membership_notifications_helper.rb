# frozen_string_literal: true

module MembershipNotificationsHelper
  def profile_completion_rate(user)
    i = 0
    i += 1 if user.identities.any?
    i += 1 if user.addresses.any?
    100 * i / 2
  end
end
