# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user

    if user.agent?
      can :manage, SupportTicket
      can :manage, Comment
    elsif user.customer?
      can :create, SupportTicket
      can :read, SupportTicket, user_id: user.id
      can :create, Comment do |comment|
        comment.support_ticket.agent_has_commented?
      end
      can :read, Comment, support_ticket: { user_id: user.id }
    end
  end
end
