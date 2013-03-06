module Web::WorkshopsHelper
  def workshops
    @workshops ||= Workshop.web
  end
end
