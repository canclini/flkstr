# -*- encoding : utf-8 -*-
class DashboardController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    redirect_to new_company_path unless current_company
        
    @leads = current_company.leads.new_or_accepted
    @company = current_company
    @update = Update.new(:twitter => @company.setting.default_twitter_send)
    @latest_update = @company.updates.last
    
    @feeds = @company.feed_items.limit(10)
  end

  private
end
