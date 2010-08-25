class ApplicationController < ActionController::Base
  protect_from_forgery

  helper :all
  
  before_filter :set_user_language
  
  helper_method :flockstreet?, :current_company, :no_user!, :needs_company!
  
  def after_sign_in_path_for(resource_or_scope)
      dashboard_url
  end
  
  def after_sign_up_path_for(resource_or_scope)
    new_company_path
  end
  
  private
  
  def no_user!
    if user_signed_in?
      flash[:notice] = "Only logged out Users"
      redirect_to root_url
    end
  end
    
  def needs_company!
    unless user_signed_in? && current_company?
      flash[:notice] = "Du bist nicht Mitglied einer Firma"
      redirect_to root_url
    end
  end
  
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
  
  def current_company?
    !!current_company
  end  
  
  def current_company
    if user_signed_in?
      @current_company ||= current_user.company
    else
      false
    end
  end
  
end
