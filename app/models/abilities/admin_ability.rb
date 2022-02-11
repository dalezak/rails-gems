class AdminAbility
  include CanCan::Ability

  def initialize(user)
    can :manage, Gemm
    can :like, Gemm

    can :manage, User

    can :manage, Tag

    can :manage, Like
  end

end
