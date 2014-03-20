module Web::PagesHelper
  def is_contacts_page?
    request.path == '/pages/contacts'
  end
end
