class PostPolicy < ApplicationPolicy
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
    true if profile.doctor? && active && @wall == post.wall
  end

  def destroy?
    true if profile.doctor? && active && @wall == post.wall
  end

  def comments?
    true if profile.doctor? && active
  end

  def add_comment?
    true if profile.doctor? && active
  end

  def like?
    true if profile.doctor? && active
  end

  def unlike?
    true if profile.doctor? && active
  end

  def wall_posts?
    true
  end

  def posts_find_by_tag?
    true
  end

  private
    def post
      record
    end
end
