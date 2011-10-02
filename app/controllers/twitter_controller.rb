# -*- encoding : utf-8 -*-
class TwitterController < ApplicationController
  before_filter :twitter_wrapper, :authenticate_user!
  
  def signin
    begin
      session[:rtoken], session[:rsecret] = @wrapper.request_tokens
      redirect_to @wrapper.authorize_url
    rescue
      flash[:error] = 'Error while connecting with Twitter. Please try again.'
      redirect_to settings_path
    end
  end
  
  def auth
    begin
      @wrapper.auth(session[:rtoken], session[:rsecret], params[:oauth_verifier])
      flash[:notice] = "Successfully signed in with Twitter."
    rescue
      flash[:error] = 'You were not authorized by Twitter!'
    end
    redirect_to settings_path
  end
  
  def tweet
    begin
      @twitter = @wrapper.get_twitter
      @twitter.update params[:tweet]
      flash[:notice] = "Tweet successfully sent!"
    rescue
      flash[:error] = "Error sending the tweet! Twitter might be unstable. Please try again."
    end
    redirect_to dashboard_path
  end
  
end
