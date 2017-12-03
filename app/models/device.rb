class Device < ApplicationRecord
  include Auth
  belongs_to :user

  validates_uniqueness_of :device_name
  enum devise_os: %i[android ios windows linux mac_os]

  has_many :auth_tokens, as: :tokenable, autosave: true
end
