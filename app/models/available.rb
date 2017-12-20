class Available < ApplicationRecord
  belongs_to :availability,  polymorphic: true

  before_create :datetime_uniqueness

  private
    def datetime_uniqueness
      availables = availability.availables.where(date: self.date)
      if availables.present?
        availables.each do |date|
          raise BadRequestError, I18n.t("messages.date.date_cover") if (self.start_time..self.end_time).cover?(date.start_time) || (self.start_time..self.end_time).cover?(date.end_time)
        end
      end
    end
end
