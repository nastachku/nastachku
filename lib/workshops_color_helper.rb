module WorkshopsColorHelper
  def workshops_color_hash
    @workshops_hash ||= Workshop.all
    hash = { "#{@workshops_hash[0].title}" => "green", "#{@workshops_hash[1].title}" => "yellow",
      "#{@workshops_hash[2].title}" => "orange", "#{@workshops_hash[3].title}" => "blue",
      "#{@workshops_hash[4].title}" => "red", "#{@workshops_hash[5].title}" => "purple"}
    hash
  end
end
