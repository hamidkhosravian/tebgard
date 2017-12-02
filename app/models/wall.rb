class Wall < ApplicationRecord
  belongs_to :profile

  validates_uniqueness_of :doctor_code
  acts_as_taggable_on :skills

  before_validation :generate_uuid

  private
    def generate_random_hex(n = 1, predicate = proc {})
        hex = SecureRandom.hex(n)
        hex = SecureRandom.hex(n) while predicate.call(hex)
        hex
    end

    def generate_uuid
      self.uuid = generate_random_hex(8, ->(hex) { Wall.exists?(uuid: hex) }) if self.new_record?
    end
end
