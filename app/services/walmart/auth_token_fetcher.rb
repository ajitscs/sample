# frozen_string_literal: true

module Walmart
  class AuthTokenFetcher
    def self.call(account:)
      new(account).call
    end

    def initialize(account)
      @account = account
    end

    def call
      return account.access_token unless account.token_expired?

      refresh_token!
      account.access_token
    end

    private

    attr_reader :account

    def refresh_token!
      response = request_new_token

      account.update!(
        access_token: response[:access_token],
        token_expires_at: Time.current + response[:expires_in].seconds
      )
    end

    def request_new_token
      # mocked response for sample code
      {
        access_token: SecureRandom.hex(32),
        expires_in: 3600
      }
    end
  end
end
