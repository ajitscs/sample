# frozen_string_literal: true

RSpec.describe Walmart::WebhookProcessor do
  it "updates order status on ORDER_STATUS_CHANGE event" do
    order = WalmartOrder.create!(
      walmart_order_id: "123",
      status: "pending"
    )

    payload = {
      eventType: "ORDER_STATUS_CHANGE",
      orderId: "123",
      status: "shipped"
    }.to_json

    described_class.call(payload: payload)

    expect(order.reload.status).to eq("shipped")
  end
end
