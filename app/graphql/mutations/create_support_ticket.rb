# frozen_string_literal: true

module Mutations
  class CreateSupportTicket < BaseMutation
    argument :title, String, required: true
    argument :description, String, required: true

    field :support_ticket, Types::SupportTicketType, null: true
    field :errors, [String], null: false

    def resolve(title:, description:)
      user = context[:current_user]
      return { support_ticket: nil, errors: ["Authentication required"] } unless user

      ticket = user.support_tickets.build(title: title, description: description)

      if ticket.save
        { support_ticket: ticket, errors: [] }
      else
        { support_ticket: nil, errors: ticket.errors.full_messages }
      end
    end
  end
end
