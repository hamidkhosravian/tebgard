class Relationship < ApplicationRecord
  belongs_to :follower, class_name: "Wall"
  belongs_to :followed, class_name: "Wall"

  validates :follower_id, presence: true
  validates :followed_id, presence: true
end
