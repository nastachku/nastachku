class Web::MembersController < Web::ApplicationController

  def index
    @members = Member.shown_as_participants
  end

  def new
    @member = MemberEditType.new
  end

  def create
    @member = MemberEditType.new(params[:member])
    
    if @member.save
      flash_success
      redirect_to root_path
    else
      flash_error
      render action: "new"
    end
  end

end