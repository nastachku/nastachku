module Web::PagesHelper
  # TODO: убрать
  def is_contacts_page?
    request.path == '/pages/contacts'
  end
end
