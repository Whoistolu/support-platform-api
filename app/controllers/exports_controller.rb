class ExportsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_agent!

  def tickets_csv
    csv_data = CsvExporter.export_closed_tickets
    send_data csv_data, filename: "closed_tickets_last_month.csv"
  end

  private

  def authorize_agent!
    unless current_user.agent?
      redirect_to root_path, alert: "Access denied."
    end
  end
end
