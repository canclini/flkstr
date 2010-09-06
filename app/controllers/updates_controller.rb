class UpdatesController < ApplicationController
  before_filter :authenticate_user!, :twitter_wrapper
  
  def create
    @company = current_company
    @update = @company.updates.build(:message => params[:update])

    begin
      @twitter = @wrapper.get_twitter
      @twitter.update params[:update]
      flash[:notice] = "Tweet successfully sent!"
    rescue
      flash[:error] = "Error sending the tweet! Twitter might be unstable. Please try again."
    end

#    if @update.save
#        flash[:notice] = "Dein Update wurde veroeffentlicht"
#    else
#        flash[:error] = "Da ging was schief..."
#    end
    redirect_to dashboard_path()
  end
  
  private
  
  def twitter_wrapper
    @wrapper = TwitterWrapper.new File.join(Rails.root, 'config', 'twitter.yml'), current_company
  end
  
end
