class Web::Account::SpeakersController < Web::Account::ApplicationController

  def edit
    @speaker = SpeakerEditType.find params[:id]
  end

  def update
    @speaker = SpeakerEditType.find params[:id]

    if @speaker.update_attributes params[:speaker]
      flash_success
      redirect_to root_path
    else
      flash_error
      render action: "edit"
    end
  end

end