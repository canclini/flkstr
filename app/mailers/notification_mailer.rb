# -*- encoding : utf-8 -*-
class NotificationMailer < ActionMailer::Base
  default :from => "notify@flockstreet.com"
  
  def single(user, notification)
    @user = user
    @company = @user.company
    @notifiable = notification.notifiable
    mail(:to => @user.email, :subject => "Notification Email")
  end
  
  def group(user, notifications)
    @user = user
    @company = @user.company    
    @leads = notifications.leads
    @messages = notifications.messages
    mail(:to => @user.email, :subject => "Notification Summary Email")
  end
end
