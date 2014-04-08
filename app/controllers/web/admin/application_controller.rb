class Web::Admin::ApplicationController < Web::ApplicationController
  include DataHelper
  before_filter :authenticate_admin!
  include Data::UsersListsDataHelper
  include Data::TimepadDataHelper
end
