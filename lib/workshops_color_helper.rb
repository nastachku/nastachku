module WorkshopsColorHelper
  def workshops_color_hash
    workshops ||= Workshop.pluck(:title)
    colors = ["green", "yellow", "orange", "blue", "red", "purple"]
    pairs = workshops.zip colors
    hash = Hash[pairs]
    hash
  end
end
