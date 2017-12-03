class Article < ApplicationRecord
  belongs_to :wall
  acts_as_taggable_on :article_tags

  validates :body, :presence => true
  before_validation :generate_uuid

  private

  def generate_random_hex(n = 1, predicate = proc {})
    hex = SecureRandom.hex(n)
    hex = SecureRandom.hex(n) while predicate.call(hex)
    hex
  end

  def generate_uuid
    self.uuid = generate_random_hex(12, ->(hex) { Article.exists?(uuid: hex) }) if new_record?
  end
end
