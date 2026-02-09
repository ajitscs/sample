# frozen_string_literal: true

module Walmart
  class ApiClient
    BASE_URL = "https://marketplace.walmartapis.com"

    def initialize(account:)
      @account = account
      @connection = Faraday.new(BASE_URL) do |f|
        f.request :json
        f.response :json
      end
    end

    def get_orders
      get("/v3/orders")
    end

    def get_order(order_id)
      get("/v3/orders/#{order_id}")
    end

    private

    attr_reader :account

    def get(path)
      response = @connection.get(path, headers)
      response.body.dig("list", "elements") || []
    end

    def headers
      {
        "WM_SVC.NAME" => "Walmart Marketplace",
        "WM_QOS.CORRELATION_ID" => SecureRandom.uuid,
        "Authorization" => "Bearer #{access_token}"
      }
    end

    def access_token
      Walmart::AuthTokenFetcher.call(account: account)
    end
  end
end
