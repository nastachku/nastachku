class Speaker < User
  include SpeakerRepository

  mount_uploader :photo, UsersPhotoUploader

  def member?
    false
  end

  def speaker?
    true
  end

end
