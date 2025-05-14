class SupportTicket < ApplicationRecord
  belongs_to :user

  enum status: { open: 0, pending: 1, closed: 2 }
end
