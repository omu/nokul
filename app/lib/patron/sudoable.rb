# frozen_string_literal: true

module Patron
  module Sudoable
    extend ActiveSupport::Concern

    class_methods do
      # Usage:
      #   sudo  # sudo mode enabled for all actions
      #   sudo only: %i[new edit destroy]
      #   sudo only: [:new, :edit] if: :foo?
      #   sudo except: :destroy, timeout: 1.minutes
      #   sudo timeout: 30.minutes # custom timeout definition
      def sudo(**options)
        before_action(options) do
          next unless Sudo.required?(session[:sudo], timeout: options[:timeout])

          render 'patron/confirmations/new', layout: 'guest'
        end
      end
    end

    protected

    def extend_sudo_session!
      session[:sudo] = Time.current
    end

    def reset_sudo_session!
      session[:sudo] = nil
    end
  end
end
