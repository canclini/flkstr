class MessageCopy < ActiveRecord::Base
  belongs_to :message
  belongs_to :recipient, :class_name => "Company"
  delegate :author, :created_at, :subject, :body, :recipients, :to => :message
  
  
  after_save :add2feeds
  
  private
  
  def add2feeds
    feed_item = FeedItem.create(:item => self.message)
    recipient.feed_items << feed_item 
  end
end
