module Web::LectorsHelper

  def topics
    @topics ||= Topic.web
  end
end
