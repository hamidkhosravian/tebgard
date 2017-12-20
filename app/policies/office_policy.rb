class OfficePolicy < ApplicationPolicy
  def index?
    true if profile.doctor? && active
  end

  def show?
    true
  end

  def create?
    true if profile.doctor? && active
  end

  def update?
    true if profile.doctor? && active && @wall == office.wall
  end

  def destroy?
    true if profile.doctor? && active && @wall == office.wall
  end

  def upload_file?
    true if profile.doctor? && active && @wall == office.wall
  end

  def wall_offices?
    true
  end

  private
    def office
      record
    end
end
