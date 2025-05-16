module Mutations
  class CreateComment < BaseMutation
    argument :support_ticket_id, ID, required: true
    argument :body, String, required: true

    field :comment, Types::CommentType, null: true
    field :errors, [String], null: false

   def resolve(support_ticket_id:, body:)
      user = context[:current_user]
      return { comment: nil, errors: ["Authentication required"] } unless user

      ticket = SupportTicket.find_by(id: support_ticket_id)
      return { comment: nil, errors: ["Support ticket not found"] } unless ticket

      comment = ticket.comments.build(user: user, body: body)

      authorize! :create, comment

      if comment.save
        { comment: comment, errors: [] }
      else
        { comment: nil, errors: comment.errors.full_messages }
      end
    end
  end
end
