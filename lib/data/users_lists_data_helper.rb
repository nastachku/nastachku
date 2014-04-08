module Data::UsersListsDataHelper
  def upload_list_from_file(file_path)
    table = SmarterCSV.process(file_path)
    users_list = []
    other_users_list = []
    table.map do |row|
      user = User.find_by_email row[I18n.t('users_lists.data.email').to_sym]
      if user
        users_list << user
      else
        other_users_list << row
      end
    end
    [users_list, other_users_list]
  end
end
