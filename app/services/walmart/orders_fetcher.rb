# frozen_string_literal: true

module Walmart
  class OrdersFetcher
    def self.call(account:)
      new(account).call
    end

    def initialize(account)
      @account = account
    end

    def call
      client.get_orders.map do |raw_order|
        validated = Walmart::Contracts::OrderContract.validate!(raw_order)
        persist_order(validated)
      end
    rescue Walmart::ValidationError => e
      Rails.logger.warn("[Walmart] Invalid order payload: #{e.message}")
      []
    end

    private

    attr_reader :account

    def client
      Walmart::ApiClient.new(account: account)
    end

    def persist_order(order)
      WalmartOrder.find_or_create_by!(
        walmart_order_id: order[:id],
        status: order[:status]
      )
    end
  end
end
