# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    if user.has_role? :admin
      can :manage, :all
    elsif user.has_role? :employee
      # Employee can read and update their own profile
      can [:read, :update], Employee, user_id: user.id

      # Employee can manage their own bills but cannot change status if it's approved or rejected
      can [:read, :create, :update, :destroy], Bill, employee_id: user.employee.id
      cannot :update, Bill, status: ['approved', 'rejected']

      can :change_password, Employee
      can :update_password, Employee
    else
      can :read, :all # default permissions
    end
  end
end
