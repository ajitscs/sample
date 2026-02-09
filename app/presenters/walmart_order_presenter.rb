# frozen_string_literal: true

class WalmartOrderPresenter
  def initialize(resource)
    @resource = Array(resource)
  end

  def as_json
    @resource.map do |order|
      {
        id: order.walmart_order_id,
        status: order.status,
        created_at: order.created_at
      }
    end
  end
end
