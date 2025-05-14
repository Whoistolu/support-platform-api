class SupportTicket < ApplicationRecord
  belongs_to :user

  enum status: { open: 0, pending: 1, closed: 2 }
  has_many_attached :attachments
  has_many :comments, dependent: :destroy

  def agent_has_commented?
    comments.joins(:user).where(users: { role: "agent" }).exists?
  end
end
