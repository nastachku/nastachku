class AdminConstraint
  
  def matches?(request)
    session = request.session
    current_user = User.find_by_id(session[:user_id])
    current_user && current_user.admin?
  end
end
