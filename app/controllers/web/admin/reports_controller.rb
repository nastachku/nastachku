class Web::Admin::ReportsController < Web::Admin::ApplicationController
  def generate
    FileUtils.mkdir_p('downloads')
    FileUtils.mkdir_p('downloads/reports')

    TicketReport.generate :ticket, 'downloads/reports/ticketorders.csv'
    TicketReport.generate :afterparty_ticket, 'downloads/reports/afterpartyorders.csv'
    download_orders_in_csv('downloads/reports/paid_users.csv')

    redirect_to admin_root_path
  end

  def download
    filename = [params[:filename], params[:format]].join('.')
    path = Rails.root.join( 'downloads/reports', filename )
    if File.exists?(path)
      send_file( path, x_sendfile: true )
    else
      raise ActionController::RoutingError, "resource not found"
    end
  end

  def users_email
    @csv_streamer = UsersCsvStreamer.new

    response.headers["Cache-Control"] ||= "no-store, no-cache, must-revalidate"
    response.headers["Content-Type"] ||= "text/csv"
    response.headers["Content-Disposition"] ||= "attachment; filename=#{@csv_streamer.filename}"
    self.response_body = @csv_streamer
  end
end
