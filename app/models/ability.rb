class Ability
  include CanCan::Ability

  def initialize(user)
    cannot %i[manage read], :all
    user ||= User.new # guest user (not logged in)
    if user.admin?
      can :manage, :all
    else
      can :manage, :task
      can :manage, :user
      can :manage, :category
      can :manage, Task, user_id: user.id
      can :manage, User, id: user.id
      can :manage, Category, user_id: user.id
    end
  end
end
