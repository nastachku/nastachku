module Web::PagesHelper
  # TODO: убрать
  def is_contacts_page?
    request.path == '/contacts'
  end
end
