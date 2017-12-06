class Wall < ApplicationRecord
  belongs_to :profile
  has_many   :offices
  has_many   :posts
  has_many   :articles

  has_many :active_relationships, class_name:  "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name:  "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  has_many :comments

  validates_uniqueness_of :doctor_code
  acts_as_taggable_on :skills
  acts_as_votable

  before_validation :generate_uuid

   # Follows a user.
   def follow(id)
     active_relationships.create(followed_id: id) unless self.id == id
   end
   # Unfollows a user.
   def unfollow(id)
     active_relationships.find_by(followed_id: id).destroy unless self.id == id
   end
   # Returns true if the current user is following the other user.
   def following?(wall)
     following.include?(wall)
   end

  private

  def generate_random_hex(n = 1, predicate = proc {})
    hex = SecureRandom.hex(n)
    hex = SecureRandom.hex(n) while predicate.call(hex)
    hex
  end

  def generate_uuid
    self.uuid = generate_random_hex(12, ->(hex) { Wall.exists?(uuid: hex) }) if new_record?
  end
end
