class Request < ActiveRecord::Base
  acts_as_taggable
  acts_as_taggable_on :tags
  
  after_create :add2feeds

  belongs_to :company, :counter_cache => true
  has_many :leads, :dependent => :destroy
  has_many :feed_items, :as => :item, :dependent => :destroy
  
  # scope :this_month - created since the first of current month
  scope :this_month, where("created_at > ?", Date.new(Time.now.year, Time.now.month, 1))

  #validates_length_of :name, :within => 4..15, :too_long => "pick a shorter name", :too_short => "pick a longer name"
  validates_presence_of :name, :description
    
  def self.search(query)
    search = []
    unless query.nil? or query.empty?
      search = tagged_with(query)
    end
    search = search + where("name like ?", "%#{query}%")
    search
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
