# frozen_string_literal: true

module LdapSyncTrigger
  extend ActiveSupport::Concern

  module Trigger
    module_function

    def call(object, user_method)
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
        Trigger.call(self, method) if attributes.blank? || attributes.any? { |key| previous_changes.include?(key) }
      end

      after_destroy_commit do
        self.class.name == 'User' ? Ldap::Client.destroy(Ldap::Entity.new(self)) : Trigger.call(self, method)
      end
    end
  end
end
