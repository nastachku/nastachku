class AdminConstraint
  include AuthHelper
  
  def matches?(request)
    signed_as_admin?
  end
end
