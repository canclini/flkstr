class Company < ActiveRecord::Base
#  acts_as_taggable
#  acts_as_taggable_on :tags

# Paperclip stuff  
  has_attached_file :logo, :styles => { :medium => "250x250>", :thumb => "80x80#" }
  validates_attachment_size :logo, :less_than => 1.megabytes
  validates_attachment_content_type :logo, :content_type => ['image/jpeg', 'image/png']

  has_many :users
  has_many :addresses, :dependent => :destroy
  accepts_nested_attributes_for :addresses
  
#  has_many :requests, :dependent => :destroy
#  has_many :leads, :dependent => :destroy
  
  has_one :subscription, :dependent => :destroy
  has_one :plan, :through => :subscription
  
  validates_uniqueness_of :name
  validates_presence_of :name
  validates_length_of :teaser, :in=>10...140, :allow_blank => true
  validates_length_of :phone, :in => 7..32, :allow_blank => true
  validates_length_of :fax, :in => 7..32, :allow_blank => true
  
  before_create :set_permalink
  
  def to_param
    [id, permalink].join('-')
  end

  def main_address
    self.addresses.main.first
  end
  
  ############ PRIVATE ###############    
    private
    def set_permalink
       self.permalink = name.downcase.gsub(/[^0-9a-z]+/, ' ').strip.gsub(' ', '-') if name
    end
  
end
