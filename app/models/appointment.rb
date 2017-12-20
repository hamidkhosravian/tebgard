class Appointment < ApplicationRecord
  belongs_to :office
  belongs_to :profile

  validates_uniqueness_of :uuid, scope: :office

  before_validation :generate_uuid

  private
    def generate_random_hex(n = 1, predicate = proc {})
      hex = SecureRandom.uuid
      hex = SecureRandom.uuid while predicate.call(hex)
      hex
    end

    def generate_uuid
      self.uuid = generate_random_hex(16, ->(hex) { Appointment.exists?(uuid: hex) }) if new_record?
    end
end
