class Admin::NewsEditType < News
  include BasicType

  permit :slug, :title, :body
end
