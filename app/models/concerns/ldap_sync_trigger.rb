# frozen_string_literal: true

module LdapSyncTrigger
  extend ActiveSupport::Concern

  class_methods do
    def ldap_sync_trigger(user_method, observed_attributes: [])
      after_save do
        if observed_attributes.blank? ||
           observed_attributes.any? { |attribute| [*public_send("#{attribute}_previous_change")].uniq.count > 1 }
          user = (user_method == :self ? self : public_send(user_method))
          Ldap::Entity.build(user).create
        end
      end
    end
  end
end
