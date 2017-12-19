class Available < ApplicationRecord
  belongs_to :availability,  polymorphic: true
end
