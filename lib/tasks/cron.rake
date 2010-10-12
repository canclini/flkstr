# can be run with the command "rake cron"
desc "This task is called by the Heroku cron add-on"
task :cron => :environment do
    if Time.now.hour == 0 # run at midnight
      # send Notifications email
      # Notification.deliver_all
    end

  #  if Time.now.hour % 4 == 0 # run every four hours
end
