class Web::ApplicationController < ApplicationController  
  include AuthHelper
  include FlashHelper
  include Web::LectorsHelper
  include CustomUrlHelpers
  include Web::WorkshopsHelper


  #helper :all
  helper_method :edit_admin_event_cpath, :workshops

  before_filter :basic_auth if Rails.env.staging?

  before_filter :basic_auth if Rails.env.staging?

  protect_from_forgery

  helper_method :title


  before_filter do
    title t('base_name')
    title t("#{params[:controller].gsub('/', '.')}.#{params[:action]}.title")
  end

  private

  def title(part = nil)
    @parts ||= []
    unless part
      return nil if @parts.blank?
      return @parts.reverse.join(' | ')
    end
    @parts << part
  end

end
