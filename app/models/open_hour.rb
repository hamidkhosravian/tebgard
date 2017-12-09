class OpenHour < ApplicationRecord
  belongs_to :open_day
  validates_uniqueness_of :open_time, scope: :open_day
  validates_uniqueness_of :close_time, scope: :open_day
end
