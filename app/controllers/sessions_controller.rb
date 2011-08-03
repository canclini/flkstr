class SessionsController < ApplicationController
  layout 'small_footer'
  
  def new  
  end
  
  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      print "SUCCESS"
      redirect_to dashboard_url, :notice => "Logged in!"
    else
#      flash.now.alert = "Invalid email or password"
      print "ERROR"
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Logged out!"
  end
end
