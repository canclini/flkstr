class SettingsController < ApplicationController
  before_filter :authenticate_user!, :twitter_wrapper

  def index
    @company = current_company
    @setting = @company.setting
    # twitter stuff
    begin
      @twitter = @wrapper.get_twitter
    rescue
      @twitter = nil
    end
  end
  
  def update
    @company = current_company
    @setting = @company.setting.update_attributes(params[:setting])
    if @company.update_attributes(params[:company])  
      flash[:notice] = "Einstellungen gespeichert"  
      redirect_to settings_path
    else  
      render :action => 'index'  
    end
  end

end
