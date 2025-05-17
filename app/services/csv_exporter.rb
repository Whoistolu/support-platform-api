require "csv"

class CsvExporter
  def self.export_closed_tickets
    tickets = SupportTicket.closed.where("updated_at >= ?", 1.month.ago)

    CSV.generate(headers: true) do |csv|
      csv << [ "ID", "Title", "Description", "Status", "Customer Email", "Closed At" ]

      tickets.includes(:user).find_each do |ticket|
        csv << [
          ticket.id,
          ticket.title,
          ticket.description,
          ticket.status,
          ticket.user.email,
          ticket.updated_at
        ]
      end
    end
  end
end
