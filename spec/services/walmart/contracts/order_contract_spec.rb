# frozen_string_literal: true

RSpec.describe Walmart::Contracts::OrderContract do
  it "raises error when required keys are missing" do
    payload = { status: "shipped" }

    expect {
      described_class.validate!(payload)
    }.to raise_error(Walmart::ValidationError)
  end
end
