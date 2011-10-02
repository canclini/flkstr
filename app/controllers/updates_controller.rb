# -*- encoding : utf-8 -*-
class UpdatesController < ApplicationController
  before_filter :authenticate_user!, :twitter_wrapper
  
  def create
    @company = current_company
    @update = @company.updates.build(:message => params[:update])

    if @update.save
      if @update.twitter
        Delayed::Job.enqueue(TweetJob.new(@company.id, params[:update]))
      end
      flash[:notice] = "Das Update wurde veroeffentlicht"  
    else
      flash[:error] = "Da ging was schief..."
    end

    redirect_to dashboard_path()
  end  
end
