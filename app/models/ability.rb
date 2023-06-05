# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    if user
      if user.admin?
        can :manage, :all
      else
        can :read, :all
        can :create, :all
        #can :edit, Post, user: user
        can :update, [Post, Comment], user: user
        can :destroy, [Post, Comment], user: user
      end
   
    else
      can :read, :all
    end
  end
end
