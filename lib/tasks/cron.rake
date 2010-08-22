# can be run with the command "rake cron"
task :cron => :environment do
  if Time.now.hour == 0 # run at midnight
    # send Notifications email
    # Notification.deliver_all
  end
  
#  if Time.now.hour % 4 == 0 # run every four hours
  
end