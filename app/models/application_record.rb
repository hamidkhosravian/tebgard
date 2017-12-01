class ApplicationRecord < ActiveRecord::Base
  scope :newer, -> { order(id: :desc) }
  self.abstract_class = true
end
