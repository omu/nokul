# frozen_string_literal: true

module Xokul
  module Authentication
    def basic_auth?
      Configuration.user.present? && Configuration.password.present?
    end

    def bearer_auth?
      Configuration.bearer_token.present?
    end

    def token_auth?
      Configuration.access_token.present?
    end

    def authenticate
      @http = http.basic_auth user: Configuration.user, pass: Configuration.password if basic_auth?
      @http = http.auth "Bearer #{Configuration.bearer_token}" if bearer_auth?
      @http = http.auth "token #{Configuration.access_token}" if token_auth?
    end
  end
end
