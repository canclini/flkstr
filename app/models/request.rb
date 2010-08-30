class Request < ActiveRecord::Base
#  acts_as_taggable
#  acts_as_taggable_on :tags

  belongs_to :company, :counter_cache => true
  has_many :leads, :dependent => :destroy
  
  # scope :this_month - created since the first of current month
  scope :this_month, where("created_at > ?", Date.new(Time.now.year, Time.now.month, 1))

  validates_length_of :name, :within => 4..15, :too_long => "pick a shorter name", :too_short => "pick a longer name"
  validates_presence_of :name, :description
    
end
