class Post < ApplicationRecord
  belongs_to :wall
  acts_as_votable
  acts_as_taggable_on :post_tags

  validates :body, presence: true

  has_one :picture, as: :imageable, dependent: :destroy
  has_one :multimedium, as: :multimediable, dependent: :destroy
  has_one :document, as: :documentable, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy

  before_validation :generate_uuid

  private

  def generate_random_hex(n = 1, predicate = proc {})
    hex = SecureRandom.hex(n)
    hex = SecureRandom.hex(n) while predicate.call(hex)
    hex
  end

  def generate_uuid
    self.uuid = generate_random_hex(18, ->(hex) { Post.exists?(uuid: hex) }) if new_record?
  end
end
