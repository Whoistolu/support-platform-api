class SupportTicket < ApplicationRecord
  belongs_to :user

  enum status: { open: 0, pending: 1, closed: 2 }, _suffix: true
  has_many_attached :attachments
  has_many :comments, dependent: :destroy

  validates :attachments,
  blob: {
    content_type: [ "image/png", "image/jpg", "image/jpeg", "application/pdf" ],
    size_range: 1..10.megabytes
  }

  def agent_has_commented?
    comments.joins(:user).where(users: { role: "agent" }).exists?
  end
end
