class Office < ApplicationRecord
  belongs_to :wall
  has_many :open_days
  has_many :activation, as: :activable, dependent: :destroy
  has_many :pictures, as: :imageable, dependent: :destroy
  has_many :multimediums, as: :multimediable, dependent: :destroy
  has_many :documents, as: :documentable, dependent: :destroy

  reverse_geocoded_by :latitude, :longitude # can also be an IP address
  after_validation :geocode

  validates :latitude, presence: true
  validates :longitude, presence: true
  validates :address, presence: true
  validates :office_phone_number, presence: true
  validates :description, presence: true

  before_validation :generate_uuid

  def working_hours
    wh = open_days.map do |day|
      Hash[day.day.to_sym, day.open_hours.map{|h| Hash[h.open_time.strftime("%T"), h.close_time.strftime("%T")]}.inject(:merge)]
    end
    WorkingHours::Config.working_hours =  merged = wh.reduce({}) { |aggregate, hash| aggregate.merge hash }
  end

  private

  def generate_random_hex(n = 1, predicate = proc {})
    hex = SecureRandom.hex(n)
    hex = SecureRandom.hex(n) while predicate.call(hex)
    hex
  end

  def generate_uuid
    self.uuid = generate_random_hex(16, ->(hex) { Office.exists?(uuid: hex) }) if new_record?
  end
end
