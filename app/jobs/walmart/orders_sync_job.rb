# frozen_string_literal: true

class Walmart::OrdersSyncJob < ApplicationJob
  queue_as :default

  def perform(walmart_account_id)
    account = WalmartAccount.find(walmart_account_id)
    Walmart::OrdersFetcher.call(account: account)
  end
end
