class Web::LectorsController < Web::ApplicationController
  def index
    @lectors = User.as_lectors.by_created_at
  end
end
