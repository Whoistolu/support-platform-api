module Mutations
  class UpdateSupportTicket < BaseMutation
    argument :id, ID, required: true
    argument :status, String, required: true

    field :support_ticket, Types::SupportTicketType, null: true
    field :errors, [ String ], null: false

    def resolve(id:, status:)
      user = context[:current_user]
      return { support_ticket: nil, errors: [ "Authentication required" ] } unless user

      ticket = SupportTicket.find_by(id: id)
      return { support_ticket: nil, errors: [ "Ticket not found" ] } unless ticket

      authorize!(:update, ticket)

      if ticket.update(status: status)
        { support_ticket: ticket, errors: [] }
      else
        { support_ticket: nil, errors: ticket.errors.full_messages }
      end
    end
  end
end
