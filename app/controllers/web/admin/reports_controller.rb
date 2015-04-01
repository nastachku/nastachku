class Web::Admin::ReportsController < Web::Admin::ApplicationController
  def index
    @report_types = [
      "users_email",
      "users_with_tickets",
      "users_with_afterparty_tickets"
    ]
  end

  def show
    @report_type = params[:id]
    @reports = Report.by_kind(@report_type)
    @records_count = current_streamer.records.count
  end

  def download
    response.headers["Cache-Control"] ||= "no-store, no-cache, must-revalidate"
    response.headers["Content-Type"] ||= "text/csv"
    response.headers["Content-Disposition"] ||= "attachment; filename=#{current_streamer.filename}"
    self.response_body = current_streamer
  end

  private
  def current_streamer
    @current_streamer = ReportsCsvStreamer.new(params).streamer
  end
end
