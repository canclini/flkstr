class ApplicationController < ActionController::Base
  protect_from_forgery

  helper :all
  
  before_filter :set_user_language
  
  private
  def set_user_language
    I18n.locale = current_user.language if user_signed_in?
  end
end
