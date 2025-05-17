class AgentMailer < ApplicationMailer
  def daily_open_tickets(agent)
    @agent = agent
    @tickets = SupportTicket.open

    mail(
      to: @agent.email,
      subject: "Daily Reminder: Open Support Tickets"
    )
  end
end
