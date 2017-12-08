class CommentPolicy < ApplicationPolicy
  def destroy?
    true if profile.doctor? && active && wall == comment.wall
  end

  private
    def comment
      record
    end
end
