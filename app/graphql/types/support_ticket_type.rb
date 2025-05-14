module Types
    class SupportTicketType < Types::BaseObject
      field :id, ID, null: false
      field :title, String, null: false
      field :description, String, null: false
      field :status, String, null: false
      field :created_at, GraphQL::Types::ISO8601DateTime, null: false
      field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

      # Relations
      field :user, Types::UserType, null: false
      field :comments, [Types::CommentType], null: false

      # File attachments – optional, can expose as URLs or metadata
      field :attachments, [Types::ActiveStorageAttachmentType], null: false
    end
end
