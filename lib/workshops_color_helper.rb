module WorkshopsColorHelper
  def workshops_color_hash
    workshops = Workshop.all
    hash = { "#{workshops[0].title}" => "red", "#{workshops[1].title}" => "blue",
      "#{workshops[2].title}" => "orange", "#{workshops[3].title}" => "purple",
      "#{workshops[4].title}" => "green", "#{workshops[5].title}" => "yellow"}
    hash
  end
end
