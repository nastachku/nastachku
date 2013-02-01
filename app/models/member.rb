class Member < User
  include MemberRepository

  def member?
    true
  end

  def speaker?
    false
  end

end
