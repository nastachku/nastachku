module WorkshopsColorHelper
  def workshops_color_hash
    workshops = Workshop.all
    hash = { "#{workshops[0].title}" => "green", "#{workshops[1].title}" => "yellow",
      "#{workshops[2].title}" => "orange", "#{workshops[3].title}" => "blue",
      "#{workshops[4].title}" => "red", "#{workshops[5].title}" => "purple"}
    hash
  end
end
