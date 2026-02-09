# frozen_string_literal: true

class WalmartOrder < ApplicationRecord
  enum status: %i[pending shipped delivered canceled]

  validates :walmart_order_id, presence: true, uniqueness: true
end
