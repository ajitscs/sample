# frozen_string_literal: true

RSpec.describe Walmart::OrdersFetcher do
  let(:account) do
    WalmartAccount.create!(
      client_id: "client-id",
      client_secret: "client-secret",
      access_token: "token",
      token_expires_at: 1.hour.from_now
    )
  end

  subject(:service) { described_class.call(account: account) }

  it "creates walmart orders for the given account" do
    allow_any_instance_of(Walmart::ApiClient)
      .to receive(:get_orders)
      .and_return([{ id: "123", status: "shipped" }])

    expect { service }.to change { WalmartOrder.count }.by(1)
  end
end
