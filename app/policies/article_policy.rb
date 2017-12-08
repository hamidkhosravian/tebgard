class ArticlePolicy < ApplicationPolicy
  def index?
    true if profile.doctor? && active && active
  end

  def show?
    true
  end

  def create?
    true if profile.doctor? && active
  end

  def update?
    true if profile.doctor? && active && wall == article.wall
  end

  def destroy?
    true if profile.doctor? && active && wall == article.wall
  end

  def upload_file?
    true if profile.doctor? && active && wall == article.wall
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

  def wall_articles?
    true
  end

  def articles_find_by_tag?
    true
  end

  private
    def article
      record
    end
end
