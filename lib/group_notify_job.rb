# -*- encoding : utf-8 -*-
class GroupNotifyJob < Struct.new(:user_id)
  def perform
    user = User.find(user_id)
    @notifications = user.notifications.to_send
    #SEND MAIL ....
    begin
      NotificationMailer.group(user, @notifications).deliver
      #success
      @notifications.update_all(:status => :delivered, :delivered_at => Time.now)
    rescue    
    #failure
    @notifications.update_all(:status => :failed)    
    end
  end
end
