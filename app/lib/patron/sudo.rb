# frozen_string_literal: true

module Patron
  module Sudo
    extend ActiveSupport::Concern

    class_methods do
      def sudo(**options)
        options[:unless] = :sudo?

        before_action(options) do
          render 'patron/confirmations/new', layout: 'guest'
        end
      end
    end

    protected

    def sudo?
      return false if session[:sudo].nil?

      session[:sudo] >= Time.current
    end

    def set_sudo_session!
      session[:sudo] = Time.current + 15.minutes
    end

    def reset_sudo_session!
      session[:sudo] = nil
    end
  end
end
