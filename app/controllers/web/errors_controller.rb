class Web::ErrorsController < Web::ApplicationController
  layout false

  def not_found
    render :not_found, :status => 404
  end

  def internal_server_error
    render :internal_server_error, :status => 500
  end
end
