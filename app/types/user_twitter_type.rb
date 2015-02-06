class UserTwitterType < User
  include BasicType

  permit :first_name, :last_name, :photo, :twitter_name

end
