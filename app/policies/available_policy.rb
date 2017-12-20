class AvailablePolicy < ApplicationPolicy
  def office_available_index?
    true
  end

  def office_available?
    true if profile.doctor? && active && @wall == available.availability.wall
  end

  def office_update?
    true if profile.doctor? && active && @wall == available.availability.wall
  end

  def destroy?
    true if profile.doctor? && active && @wall == available.availability.wall
  end

  private
    def available
      record
    end
end
