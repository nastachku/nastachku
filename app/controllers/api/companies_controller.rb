class Api::CompaniesController < Api::ApplicationController
  def index
    @companies = User.companies_by_term params[:term]
    respond_with(@companies)
  end
end
