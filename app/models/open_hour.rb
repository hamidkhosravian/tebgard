class OpenHour < ApplicationRecord
  belongs_to :open_day
  
  validates :open_time, presence: true
  validates :close_time, presence: true
end
