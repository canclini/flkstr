class PasswordResetsController < ApplicationController
  layout 'small_footer'
  def new
  end
  
  def create
    user = User.find_by_email(params[:email])
    if user
      user.send_password_reset if user
      redirect_to root_url, :notice => "E-Mail mit Instruktionen versendet"
    else
      redirect_to new_password_reset_url, :notice => "E-Mail Adresse nicht bekannt"
    end
  end
  
  def edit
    @user = User.find_by_password_reset_token!(params[:id]) #token! raises the 404 if token is not found
  end
  
  def update
    @user = User.find_by_password_reset_token!(params[:id])
    if @user.password_reset_sent_at < 2.hours.ago
      redirect_to new_password_reset_path, :alert => "Password reset has expired."
    elsif @user.update_attributes(params[:user])
      redirect_to root_url, :notice => "Password has been reset!"
    else
      render :edit
    end
  end
end
