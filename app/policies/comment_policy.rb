class PostPolicy < ApplicationPolicy
  def destroy?
    true if profile.doctor? && profile.wall == comment.wall
  end

  private
    def comment
      record
    end
end
