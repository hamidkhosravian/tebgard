class Ability
  include CanCan::Ability

  def initialize(user)
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    #   can :update, Article, :published => true

    if user.profile.visitor?
      cannot :article, :all
      cannot :post, :all
    elsif user.profile.doctor?
      can :manage, :article
    end
  end
end
