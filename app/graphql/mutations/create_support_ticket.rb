module Mutations
  class CreateSupportTicket < BaseMutation
    argument :title, String, required: true
    argument :description, String, required: true
    argument :attachment_ids, [String], required: false

    field :support_ticket, Types::SupportTicketType, null: true
    field :errors, [ String ], null: false

    def resolve(title:, description:, attachment_ids: [])
      user = context[:current_user]
      return { support_ticket: nil, errors: ["Authentication required"] } unless user

      ticket = user.support_tickets.build(title: title, description: description)
      authorize! :create, ticket

      if ticket.save
        ticket.attachments.attach(attachment_ids) if attachment_ids.present?
        { support_ticket: ticket, errors: [] }
      else
        { support_ticket: nil, errors: ticket.errors.full_messages }
      end
    end
  end
end
