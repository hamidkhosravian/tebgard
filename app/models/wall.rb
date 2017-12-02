class Wall < ApplicationRecord
  belongs_to :profile

  validates_uniqueness_of :doctor_code
end
