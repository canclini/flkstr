class ApplicationController < ActionController::Base
  include UrlHelper
  protect_from_forgery

  layout 'application'

  helper :all
  
  before_filter :force_subdomain, :set_locale, :app_state
  
  helper_method :flockstreet?, :current_company, :no_user!, :needs_company!, :app_state,
                :available_locales, :current_locale?, :current_page_path, :current_user, :user_signed_in?
  
  def after_sign_in_path_for(resource_or_scope)
      dashboard_url
  end
  
  def after_sign_up_path_for(resource_or_scope)
    new_company_path
  end
  
  #### PROTECTED #######
  protected 


  #### PRIVATE #######
  private
  
  def force_subdomain
   if Rails.env == 'production'
     if request.subdomain != 'secure' or request.protocol != 'https'
       redirect_to :subdomain => 'secure', :protocol => 'https'
     end
   else
      if request.subdomain != 'secure' and Rails.env != 'test'
        redirect_to :subdomain => 'secure'
      end
    end
  end
    
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

  def set_locale
    # update session if passed
    session[:locale] = params[:locale] if params[:locale]

    # set locale based on session or default 
    I18n.locale = session[:locale] || I18n.default_locale
    logger.debug "* Locale set to '#{I18n.locale}'"
  end
  
  def available_locales
    #I18n.available_locales.map(&:to_s).sort
    #["de","fr"]
    ["de"]
  end

  def current_locale?(l)
    l.to_sym == I18n.locale.to_sym
  end
  
  def current_page_path(options={})
    url_for( {:controller => self.controller_name, :action => self.action_name}.merge(options) )
  end
  
  def app_state
    @app_state = 'beta'
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

  def user_signed_in?
    current_user
  end
  
  def authenticate_user!
    unless user_signed_in?
      store_target_location
      redirect_to login_url, :alert => "You must first log in or sign up before accessing this page."
    end
  end  

  def redirect_to_target_or_default(default, *args)
    redirect_to(session[:return_to] || default, *args)
    session[:return_to] = nil
  end

  private

  def store_target_location
    session[:return_to] = request.url
  end
  
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_company
    if user_signed_in?
      @current_company ||= current_user.company
    else
      false
    end
  end
  
  def twitter_wrapper
    @wrapper = TwitterWrapper.new File.join(Rails.root, 'config', 'twitter.yml'), current_company
  end
  
end
