module Types
  class MutationType < Types::BaseObject
    field :create_comment, mutation: Mutations::CreateComment
    field :create_support_ticket, mutation: Mutations::CreateSupportTicket
    field :update_support_ticket, mutation: Mutations::UpdateSupportTicket
  end
end
