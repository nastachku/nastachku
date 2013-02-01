class Web::Admin::SpeakersController < Web::Admin::ApplicationController
  
  def new
    @speaker = Speaker.new
  end

  def create
    @speaker = SpeakerEditType.new(params[:speaker])
    if @speaker.save
      flash_success
      redirect_to admin_users_path
    else
      flash_error
      render "new"
    end
  end

  def show
    @speaker = Speaker.find params[:id]
  end

  def edit
    @speaker = User.find params[:id]
  end

  def update
    @speaker = User.find(params[:id])
    #TODO херовое решение, вынести или реализовать другой вариант 
    @speaker.type = :Speaker
    @speaker.save
    
    @speaker = @speaker.becomes(SpeakerEditType)    

    if @speaker.update_attributes params[:speaker]     
      flash_success
      redirect_to admin_users_path
    else
      flash_error
      render "edit"
    end
  end

end
