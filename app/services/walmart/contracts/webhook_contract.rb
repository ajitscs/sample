# frozen_string_literal: true

module Walmart
  module Contracts
    class WebhookContract
      REQUIRED_KEYS = %i[eventType orderId status].freeze

      def self.validate!(payload)
        missing = REQUIRED_KEYS - payload.keys
        raise ValidationError, "Missing webhook keys: #{missing.join(', ')}" if missing.any?
      end
    end
  end
end
