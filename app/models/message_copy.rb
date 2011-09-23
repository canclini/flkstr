class MessageCopy < ActiveRecord::Base
  belongs_to :message
  belongs_to :recipient, :class_name => "Company"
  delegate :author, :created_at, :subject, :body, :recipients, :to => :message
  has_many :feed_items, :as => :item, :dependent => :destroy
  has_many :notifications, :as => :notifiable, :dependent => :destroy
  
  
  after_save :add2feeds, :notify

  paginates_per 10;
  
  private
  
  def add2feeds
    feed_item = FeedItem.create(:item => self.message)
    recipient.feed_items << feed_item 
  end
  
  def notify
    Delayed::Job.enqueue(NotificationCreateJob.new(self.recipient.id, self))  
  end
end
