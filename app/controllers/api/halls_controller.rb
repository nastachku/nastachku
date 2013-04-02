class Api::HallsController < ApplicationController
  def sort

    halls = params[:ids]

    if halls.present?
      halls.each_with_index do |id, position|
        hall = Hall.find id
        hall.position_sorting = position
        unless hall.save
          head :bad_request
          return
        end
      end
      head :ok
    else
      head :bad_request
    end

  end
end