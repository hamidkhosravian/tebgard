class Activation < ApplicationRecord
  belongs_to :activable,  polymorphic: true
end
