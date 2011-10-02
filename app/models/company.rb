# -*- encoding : utf-8 -*-
class Company < ActiveRecord::Base
  acts_as_taggable
  acts_as_taggable_on :tags
  
  mount_uploader :logo, LogoUploader
  
  paginates_per 10;
  
# Paperclip stuff  
#  has_attached_file :logo,
#    :styles => { :medium => "95x95>", :thumb => "35x35#" },
#    :storage => :s3,
#    :s3_credentials => "#{Rails.root.to_s}/config/s3.yml",
#    :path => ":attachment/:style/:id.:extension"
  
#  validates_attachment_size :logo, :less_than => 1.megabytes
#  validates_attachment_content_type :logo, :content_type => ['image/jpeg', 'image/png']
#  scope :with_logo, where("logo_file_name <> ?",'false').limit(10)#.order('rand()')

  has_one :setting, :dependent => :destroy
  has_many :users
  has_many :addresses, :dependent => :destroy
  accepts_nested_attributes_for :addresses
  
  has_many :requests, :dependent => :destroy
  has_many :leads, :dependent => :destroy
  
  has_one :subscription, :dependent => :destroy
  has_one :plan, :through => :subscription
  
  has_many :updates, :dependent => :destroy
  
  # followers / associates
  has_many :associations, :dependent => :destroy
  has_many :associates, :through => :associations, :source => :associate
  has_many :follower_associations, :class_name => 'Association', :foreign_key => 'associate_id'
  has_many :followers, :through => :follower_associations, :source => :company
  
  # feeds
  has_many :feeds
  has_many :feed_items, :through => :feeds, :order => 'created_at desc'
  
  # messages
  has_many :sent_messages, :class_name => "Message", :foreign_key => "author_id"	 	
  has_many :received_messages, :class_name => "MessageCopy", :foreign_key => "recipient_id"    
  
  
  validates_uniqueness_of :name
  validates_presence_of :name
  validates_length_of :teaser, :in=>10...140, :allow_blank => true
  validates_length_of :phone, :in => 7..32, :allow_blank => true
  validates_length_of :fax, :in => 7..32, :allow_blank => true
  
  before_create :set_permalink
  after_create :create_related_models
  
  
  def to_param
    [id, permalink].join('-')
  end

  def self.search(query)
    search = []
    unless query.nil? or query.empty?
      search = tagged_with(query)      
    end
    search = search + where("name like ?", "%#{query}%")
    search
  end

  def main_address
    self.addresses.main.first
  end

  def accept_lead?
    leads.this_month.size < plan.leads
  end
  
  def add_request?
    requests.this_month.size < plan.requests
  end
  
  def as_json(options = {})    
    {
      :id => id,
      :name => name,
      :value => name
    }.as_json(options)
  end    
  
  ############ PRIVATE ###############    
  private
  def set_permalink
    self.permalink = name.downcase.gsub(/[^0-9a-z]+/, ' ').strip.gsub(' ', '-') if name
  end
  
  def create_related_models
    self.addresses.create(:main => true)
    self.create_setting
  end
end


#  # cancel post-processing now, and set flag...
#  before_logo_post_process do |company|
#    if company.logo_changed?
#      company.logo_processing = true
##      false # halts processing
#    end
#  end
# 
#  # ...and perform after save in background
#  after_save do |company| 
#    if company.logo_changed?
##      Delayed::Job.enqueue LogoJob.new(company.id)
#    end
#  end
# 
#  # generate styles (downloads original first)
#  def regenerate_styles!
#    self.logo.reprocess! 
#    self.logo_processing = false   
#    self.save(false)
#  end
# 
#  # detect if our source file has changed
#  def logo_changed?
#    self.logo_file_size_changed? || 
#    self.logo_file_name_changed? ||
#    self.logo_content_type_changed? || 
#    self.logo_updated_at_changed?
#  end
#
