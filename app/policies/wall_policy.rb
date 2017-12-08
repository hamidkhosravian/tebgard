class WallPolicy < ApplicationPolicy
  def create?
    true
  end

  def show?
    true
  end

  def update?
    true if wall && wall == current_wall
  end

  def add_skills?
    true if wall && wall == current_wall
  end

  def remove_skills?
    true if wall && wall == current_wall
  end


  private
    def current_wall
      record
    end
end
