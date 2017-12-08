class PostPolicy < ApplicationPolicy
  def index?
    true if profile.doctor?
  end

  def show?
    true if profile.doctor?
  end

  def create?
    true if profile.doctor?
  end

  def update?
    true if profile.doctor? && profile.wall == post.wall
  end

  def destroy?
    true if profile.doctor? && profile.wall == post.wall
  end
  
  def comments?
    true if profile.doctor?
  end

  def add_comment?
    true if profile.doctor?
  end

  def like?
    true if profile.doctor?
  end

  def unlike?
    true if profile.doctor?
  end

  def posts_find_by_tag?
    true if profile.doctor?
  end

  private
    def post
      record
    end
end
