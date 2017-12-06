class Article < ApplicationRecord
  belongs_to :wall
  acts_as_taggable_on :article_tags

  validates :title, presence: true
  validates :body, presence: true

  has_many :pictures, as: :imageable, dependent: :destroy
  has_many :multimediums, as: :multimediable, dependent: :destroy
  has_many :documents, as: :documentable, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy

  before_validation :generate_uuid

  private

  def generate_random_hex(n = 1, predicate = proc {})
    hex = SecureRandom.hex(n)
    hex = SecureRandom.hex(n) while predicate.call(hex)
    hex
  end

  def generate_uuid
    self.uuid = generate_random_hex(18, ->(hex) { Article.exists?(uuid: hex) }) if new_record?
  end
end
