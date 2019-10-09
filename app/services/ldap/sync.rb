# frozen_string_literal: true

module LDAP
  class Sync
    def initialize(context)
      @context = context
    end

    def after_commit(record)
      @record = record

      if destroyable? && client_active?
        LDAP::Client.destroy(
          LDAP::Entity.new(user)
        )
      else
        LDAP::EntitySaveJob.perform_later(user)
      end
    end

    private

    attr_reader :context, :record

    def user
      @user ||= case context
                when Proc  then context.call(record)
                when :self then record
                else            record.public_send(context)
                end
    end

    def destroyable?
      record.destroyed? && record.is_a?(User)
    end

    def client_active?
      return true if LDAP::Client.active?

      Rollbar.log('error', 'LDAP Service unavailable or authentication failed')

      false
    end
  end
end
