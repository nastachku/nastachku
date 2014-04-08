module Data::UsersListsDataHelper
  def upload_list_from_file(file_path)
    table = SmarterCSV.process(file_path)
    users_list = []
    table.map do |row|
      user = User.find_by_email row[I18n.t('users_lists.data.status').to_sym]
      if user
        users_lists << user
      end
    end
    users_lists
  end
end
