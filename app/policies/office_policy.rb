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
    true if profile.doctor? && profile.wall == office.wall
  end

  def destroy?
    true if profile.doctor? && profile.wall == office.wall
  end

  def upload_file?
    true if profile.doctor? && profile.wall == office.wall
  end

  private
    def office
      record
    end
end
