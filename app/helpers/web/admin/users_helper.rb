module Web::Admin::UsersHelper
  def options_for_category_select
    options = [
      ["Все пользователи", "users"],
      ["Докладчики", "lectors"]
    ]
    selected = params[:category]
    options_for_select(options, selected)
  end
end
