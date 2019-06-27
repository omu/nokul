# frozen_string_literal: true

module LdapSyncTrigger
  extend ActiveSupport::Concern

  class_methods do
    def ldap_sync_trigger(user_method, attributes: [])
      after_save do
        if attributes.blank? || attributes.any? { |attribute| send("#{attribute}_change?") }
          user = case user_method
                 when Proc  then user_method.call(self)
                 when :self then self
                 else            public_send(user_method)
                 end
          user.ldap_sync
        end
      end
    end
  end

  included do |klass|
    if klass.name == 'User'
      def ldap_sync
        Ldap::EntitySaveJob.perform_later(self)
      end
    end
  end
end
