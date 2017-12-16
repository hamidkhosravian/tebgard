class OpenDayPolicy < ApplicationPolicy
  def index?
    true
  end

  def create?
    true if profile.doctor? && active && @wall == open_day.office.wall
  end

  def update?
    true if profile.doctor? && active && @wall == open_day.office.wall
  end

  def destroy_day?
    true if profile.doctor? && active && @wall == open_day.office.wall
  end

  private
    def open_day
      record
    end
end
