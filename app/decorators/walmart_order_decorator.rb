# frozen_string_literal: true

class WalmartOrderDecorator < SimpleDelegator
  def display_status
    status.titleize
  end
end
