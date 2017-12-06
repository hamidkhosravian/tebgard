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

  def like?
    true if profile.doctor?
  end

  private
    def article
      record
    end
end
