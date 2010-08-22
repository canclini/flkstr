class ApplicationController < ActionController::Base
  protect_from_forgery

  helper :all
  
  before_filter :set_user_language
  
  helper_method :flockstreet?, :current_company
  
  def after_sign_in_path_for(resource_or_scope)
      dashboard_url
  end
  
  def after_sign_up_path_for(resource_or_scope)
    new_company_path
  end
  
  private
  def set_user_language
    I18n.locale = current_user.language if user_signed_in?
  end
  
  def flockstreet?
    if user_signed_in?
      current_company.name == 'flockstreet'
    else
      false
    end
  end
  
  def current_company
    if user_signed_in?
      return @current_company if defined?(@current_company)
      @current_company = current_user.company
    else
      false
    end
  end
  
end
