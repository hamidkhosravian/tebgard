class OpenDay < ApplicationRecord
  belongs_to :office
  has_many   :open_hours, dependent: :destroy
  accepts_nested_attributes_for :open_hours

  validates_uniqueness_of :day, scope: :office
  enum day: %i[sat sun mon tue wed thu fri]
end
