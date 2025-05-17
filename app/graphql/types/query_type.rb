module Types
  class QueryType < Types::BaseObject
    field :support_tickets, [Types::SupportTicketType], null: false

    def support_tickets
      user = context[:current_user]
      raise GraphQL::ExecutionError, "Not authenticated" unless user

      tickets = user.agent? ? SupportTicket.all : SupportTicket.where(user_id: user.id)
      tickets.select { |ticket| authorize!(:read, ticket); true }
    end

    field :support_ticket, Types::SupportTicketType, null: true do
      argument :id, ID, required: true
    end

    def support_ticket(id:)
      ticket = SupportTicket.find_by(id: id)
      raise GraphQL::ExecutionError, "Ticket not found" unless ticket

      authorize!(:read, ticket)
      ticket
    end
  end
end
