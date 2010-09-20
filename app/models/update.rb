class Update < ActiveRecord::Base
  belongs_to :company
  after_create :add2feeds
  
    
  def send2twitter(company)
     begin
       @twitter = @wrapper.get_twitter
       @twitter.update self.message
     rescue
        logger.warn = "Error sending the tweet! self.id, self.message"
     end
    
  end
  
  private
  def add2feeds
    # dashboard feed for followers
    feed_item = FeedItem.create(:item => self)
    company.followers.each do |follower|
      follower.feed_items << feed_item
    end
  end
  
end
