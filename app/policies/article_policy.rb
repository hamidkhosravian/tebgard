class ArticlePolicy < ApplicationPolicy
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
    true if profile.doctor? && profile.wall == article.wall
  end

  def destroy?
    true if profile.doctor? && profile.wall == article.wall
  end

  def upload_file?
    true if profile.doctor? && profile.wall == article.wall
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

  def articles_find_by_tag?
    true if profile.doctor?
  end

  private
    def article
      record
    end
end