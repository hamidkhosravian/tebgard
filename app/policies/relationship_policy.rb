class PostPolicy < ApplicationPolicy
  def followers?
    true if profile.doctor?
  end

  def following?
    true if profile.doctor?
  end

  def create?
    true if profile.doctor?
  end

  def destroy?
    true if profile.doctor?
  end

  private
    def Relationship
      record
    end
end
