# frozen_string_literal: true

module Api
  module V1
    class WalmartOrdersController < ApplicationController
      def index
        account = WalmartAccount.find(params[:account_id])
        orders = Walmart::OrdersFetcher.call(account: account)
        render json: WalmartOrderPresenter.new(orders).as_json
      end

      def show
        order = Walmart::OrderFetcher.call(params[:id])
        render json: WalmartOrderPresenter.new(order).as_json
      end
    end
  end
end
