# frozen_string_literal: true

module Api
  module V1
    class WalmartWebhooksController < ApplicationController
      skip_before_action :verify_authenticity_token

      def create
        Walmart::WebhookProcessor.call(payload: request.raw_post)
        head :ok
      end
    end
  end
end
