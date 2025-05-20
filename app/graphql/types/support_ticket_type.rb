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
    field :comments, [ Types::CommentType ], null: false

    # Active Storage
    field :attachments, [ Types::ActiveStorageAttachmentType ], null: false

    # URLs for client use
    field :attachment_urls, [ String ], null: true

    def attachment_urls
      object.attachments.map do |file|
        Rails.application.routes.url_helpers.rails_blob_url(file, only_path: true)
      end
    end
  end
end
