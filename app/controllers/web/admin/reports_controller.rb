class Web::Admin::ReportsController < Web::Admin::ApplicationController
  def generate
    Dir.mkdir("downloads") unless File.exists?("downloads")
    Dir.mkdir("downloads/reports") unless File.exists?("downloads/reports")
    download_orders_in_csv("downloads/reports/ticketorders.csv", "downloads/reports/afterpartyorders.csv", "downloads/reports/badges.csv", "downloads/reports/paid_users.csv")
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
end
