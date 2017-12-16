class OpenHourPolicy < ApplicationPolicy
  def index?
    true
  end

  def create?
    true if profile.doctor? && active && @wall == open_hour.open_day.office.wall
  end

  def update?
    true if profile.doctor? && active && @wall == open_hour.open_day.office.wall
  end

  def destroy_hour?
    true if profile.doctor? && active && @wall == open_hour.open_day.office.wall
  end

  private
    def open_hour
      record
    end
end
