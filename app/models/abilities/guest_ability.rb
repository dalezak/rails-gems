class GuestAbility
  include CanCan::Ability

  def initialize(user)
    can :read, Gemm

    can :read, User

    can :read, Tag
  end

end
