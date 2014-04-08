class Web::Registrator::ApplicationController < Web::ApplicationController
  before_filter :authenticate_registrator!
end
