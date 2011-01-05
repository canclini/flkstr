class ApplicationController < ActionController::Base
  include ::SslRequirement
  protect_from_forgery

  layout :specify_layout

  helper :all
  
  before_filter :set_locale, :app_state
  
  helper_method :flockstreet?, :current_company, :no_user!, :needs_company!, :app_state,
                :available_locales, :current_locale?, :current_page_path
  
  def after_sign_in_path_for(resource_or_scope)
      dashboard_url
  end
  
  def after_sign_up_path_for(resource_or_scope)
    new_company_path
  end
  
  #### PROTECTED #######
  protected 

  def specify_layout
    specific_layout = case controller_name
       when 'sessions' then 'small_footer'
       when 'passwords' then 'small_footer'
       when 'registrations' then action_name == 'edit' ? 'application' : 'small_footer'
       else "application"
    end

    specific_layout
  end

  #### PRIVATE #######
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
    #@app_state = ENV['APP_STATE']
    @app_state = 'website'
    allowed_controllers = %w[website companies registrations sessions plans price_suggestions]
    allowed_actions = %w[tags update]
    logger.debug controller_name
    if allowed_controllers.include?(controller_name)
      #continue
    else
      if controller_name == 'companies' and allowed_actions.include?(action_name)
        #continue
      else
        redirect_to root_url
      end
    end
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
  
  def twitter_wrapper
    @wrapper = TwitterWrapper.new File.join(Rails.root, 'config', 'twitter.yml'), current_company
  end
  
end
