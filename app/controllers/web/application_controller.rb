class Web::ApplicationController < ApplicationController  
  include AuthHelper
  include FlashHelper
  include Web::LectorsHelper

  protect_from_forgery

  helper_method :title

  private

  def title(part = nil)
    @parts ||= []
    unless part
      return nil if @parts.blank?
      return @parts.reverse.join(' - ')
    end
    @parts << part
  end

end
