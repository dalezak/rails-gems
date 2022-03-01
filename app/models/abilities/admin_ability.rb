class AdminAbility
  include CanCan::Ability

  def initialize(user)
    can :manage, Gemm
    can :like, Gemm
    can :share, Gemm

    can :manage, User
    can :share, User

    can :manage, Tag
    can :share, Tag

    can :manage, Like
  end

end
