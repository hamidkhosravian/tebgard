class OpenDay < ApplicationRecord
  belongs_to :office

  validates_uniqueness_of :day, scope: :office
  enum day: %i[Saturday Sunday Monday Tuesday Wednesday Thursday Friday]
end
