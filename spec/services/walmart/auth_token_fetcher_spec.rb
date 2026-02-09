# frozen_string_literal: true

RSpec.describe Walmart::AuthTokenFetcher do
  let(:account) do
    WalmartAccount.create!(
      client_id: "id",
      client_secret: "secret",
      access_token: "old",
      token_expires_at: 1.hour.ago
    )
  end

  it "refreshes token when expired" do
    token = described_class.call(account: account)

    expect(token).not_to eq("old")
    expect(account.reload.token_expires_at).to be_future
  end
end
