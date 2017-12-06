class Comment < ApplicationRecord
  belongs_to :wall
  belongs_to :commentable, polymorphic: true

  validates :body, presence: true

  before_validation :generate_uuid

  private

  def generate_random_hex(n = 1, predicate = proc {})
    hex = SecureRandom.hex(n)
    hex = SecureRandom.hex(n) while predicate.call(hex)
    hex
  end

  def generate_uuid
    self.uuid = generate_random_hex(24, ->(hex) { Comment.exists?(uuid: hex) }) if new_record?
  end
end
