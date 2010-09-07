class DashboardController < ApplicationController
  before_filter :authenticate_user!, :twitter_wrapper
  
  def index
    redirect_to new_company_path unless current_company
    
    # twitter stuff
    begin
      @twitter = @wrapper.get_twitter
    rescue
      @twitter = nil
    end
    
    @leads = current_company.leads.new_or_accepted
    @company = current_company
    @latest_update = @company.updates.last
  end

  private
  
  def twitter_wrapper
    @wrapper = TwitterWrapper.new File.join(Rails.root, 'config', 'twitter.yml'), current_company
  end
end
