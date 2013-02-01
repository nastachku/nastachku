class Web::Account::MembersController < Web::Account::ApplicationController

  def edit
    @member = MemberEditType.find params[:id]
  end

  def update
    @member = MemberEditType.find params[:id]

    if @member.update_attributes params[:member]
      flash_success
      redirect_to root_path
    else
      flash_error
      render action: "edit"
    end
  end

end