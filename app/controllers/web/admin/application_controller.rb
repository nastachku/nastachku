class Web::Admin::ApplicationController < Web::ApplicationController
  include DataHelper
  before_filter :authenticate_admin!
end
