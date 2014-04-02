if Rails.env == "development"
  def require_all_in(folder)
    Dir.foreach(folder) do |name|
      if name =~ /\.rb$/
        puts "REQUIRING DEPENDENCY: #{name}"
        require_dependency name unless name == "." || name == ".."
      else
        puts "SKIP #{name}"
      end
    end
  end
  require_all_in("#{Rails.root}/app/models")
  require_all_in("#{Rails.root}/app/decorators")
end
