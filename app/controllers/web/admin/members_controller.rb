class Web::Admin::MembersController < Web::Admin::ApplicationController
  
  def new
    @member = Member.new
  end

  def create
    @member = MemberEditType.new(params[:member])
    if @member.save
      flash_success
      redirect_to admin_users_path
    else
      flash_error
      render "new"
    end
  end

  def show
    @member = Member.find params[:id]
  end

  def edit
    @member = User.find params[:id]
  end

  def update
    @member = User.find(params[:id])
    #TODO херовое решение, вынести или реализовать другой вариант
    @member.type = :Member
    @member.save

    @member = @member.becomes(MemberEditType)    

    if @member.update_attributes params[:member]     
      flash_success
      redirect_to admin_users_path
    else
      flash_error
      render "edit"
    end
  end

end
