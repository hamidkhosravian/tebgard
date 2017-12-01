class AuthToken < ApplicationRecord
  belongs_to :tokenable, polymorphic: true

  validates :token, length: { minimum: 20 }, uniqueness: true
  validates :refresh_token, length: { minimum: 20 }, uniqueness: true
  validates_datetime :token_expires_at, after: -> { DateTime.now }, on: [:create]
end
