class Api::CitiesController < Api::ApplicationController
  def index
    @cities = User.cities_by_term params[:term]
    respond_with(@cities)
  end
end
