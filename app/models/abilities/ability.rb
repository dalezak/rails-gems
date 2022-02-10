class Ability
  include CanCan::Ability

  def initialize(user)
    alias_action :read, :create, to: :read_create
    alias_action :read, :update, to: :read_update
    alias_action :read, :create, :update, to: :read_create_update
    alias_action :update, :destroy, to: :update_destroy
    alias_action :read, :update, :destroy, to: :read_update_destroy
    if user.nil?
      self.merge(GuestAbility.new(user))
    elsif user.is_a?(Admin)
      self.merge(AdminAbility.new(user))
    else
      self.merge(UserAbility.new(user))
    end
  end

  def as_json(options = {})
    rules.map do |rule| {
        base_behavior: rule.base_behavior,
        actions: rule.actions.as_json,
        subjects: rule.subjects.map(&:to_s),
        conditions: rule.conditions.as_json
      }
    end
  end

end
