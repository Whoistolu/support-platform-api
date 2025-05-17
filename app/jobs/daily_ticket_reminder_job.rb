class DailyTicketReminderJob < ApplicationJob
  queue_as :default

  def perform
    User.agent.find_each do |agent|
      AgentMailer.daily_open_tickets(agent).deliver_later
    end
  end
end
