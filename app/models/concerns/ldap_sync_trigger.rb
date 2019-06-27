# frozen_string_literal: true

module LdapSyncTrigger
  extend ActiveSupport::Concern

  module Trigger
    module_function

    def start(object, user_method)
      user = case user_method
             when Proc  then user_method.call(object)
             when :self then object
             else            object.public_send(user_method)
             end

      Ldap::EntitySaveJob.perform_later(user)
    end
  end

  class_methods do
    def ldap_sync_trigger(method, attributes: [])
      after_save_commit do
        return unless attributes.blank? ||
                      attributes.any? { |attribute| [*send("#{attribute}_previous_change")].uniq.count > 1 }

        Trigger.start(self, method)
      end

      after_destroy_commit do
        return Ldap::Client.destroy(Ldap::Entity.new(self)) if self.class.name == 'User'

        Trigger.start(self, method)
      end
    end
  end
end
