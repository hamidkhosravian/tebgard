class Wall < ApplicationRecord
  belongs_to :profile

  validates_uniqueness_of :doctor_code
  acts_as_taggable_on :skills
end
