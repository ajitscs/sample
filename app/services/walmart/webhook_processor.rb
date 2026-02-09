# frozen_string_literal: true

module Walmart
  class WebhookProcessor
    def self.call(payload:)
      new(payload).call
    end

    def initialize(payload)
      @payload = JSON.parse(payload, symbolize_names: true)
    end

    def call
      Walmart::Contracts::WebhookContract.validate!(@payload)

      case @payload[:eventType]
      when "ORDER_STATUS_CHANGE"
        handle_status_change
      end
    rescue Walmart::ValidationError => e
      Rails.logger.error("[Walmart Webhook] #{e.message}")
    end

    private

    def handle_status_change
      order = WalmartOrder.find_by(walmart_order_id: @payload[:orderId])
      order&.update!(status: @payload[:status])
    end
  end
end
