# frozen_string_literal: true

class WalmartAccount < ApplicationRecord
  # Schema:
  # t.string   :client_id
  # t.string   :client_secret
  # t.string   :access_token
  # t.datetime :token_expires_at
  
  validates :client_id, :client_secret, presence: true

  def token_expired?
    access_token.blank? || token_expires_at < Time.current
  end
end
