# can be run with the command "rake cron"
desc "This task is called by the Heroku cron add-on"
task :cron => :environment do
      # send Notifications email
      Notification.schedule_daily
    
    if Time.now.strftime("%w") == "1" #day of the week (Sunday is 0, 0..6)
      Notification.schedule_weekly
    end
    

  #  if Time.now.hour % 4 == 0 # run every four hours
end
