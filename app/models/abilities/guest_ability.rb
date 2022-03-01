class GuestAbility
  include CanCan::Ability

  def initialize(user)
    can :read, Gemm
    can :share, Gemm

    can :read, User
    can :share, User

    can :read, Tag
    can :share, Tag
  end

end
