class Admin::PageEditType < Page
  include BasicType

  permit :title, :slug, :body
end
