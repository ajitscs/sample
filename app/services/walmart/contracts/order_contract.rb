# frozen_string_literal: true

module Walmart
  module Contracts
    class OrderContract
      REQUIRED_KEYS = %i[id status].freeze

      VALID_STATUSES = %w[pending shipped delivered canceled].freeze

      def self.validate!(payload)
        new(payload).validate!
      end

      def initialize(payload)
        @payload = payload.symbolize_keys
      end

      def validate!
        validate_required_keys
        validate_status
        payload
      end

      private

      attr_reader :payload

      def validate_required_keys
        missing = REQUIRED_KEYS - payload.keys
        raise ValidationError, "Missing keys: #{missing.join(', ')}" if missing.any?
      end

      def validate_status
        return if VALID_STATUSES.include?(payload[:status])

        raise ValidationError, "Invalid status: #{payload[:status]}"
      end
    end
  end
end
