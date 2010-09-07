class Update < ActiveRecord::Base
  belongs_to :company  
    
  def send2twitter(company)
     begin
       @twitter = @wrapper.get_twitter
       @twitter.update self.message
     rescue
        logger.warn = "Error sending the tweet! self.id, self.message"
     end
    
  end
end
