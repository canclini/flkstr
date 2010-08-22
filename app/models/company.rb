class Company < ActiveRecord::Base
#  acts_as_taggable
#  acts_as_taggable_on :tags
  
#  has_attached_file :logo, 
#                    :styles => { :medium => "300x300>",
#                                 :thumb => "100x100#" }

  has_many :users
#  has_many :addresses, :dependent => :destroy
#  has_many :requests, :dependent => :destroy
#  has_many :leads, :dependent => :destroy
  
#  has_one :subscription, :dependent => :destroy
#  has_one :plan, :through => :subscription
  
  validates_uniqueness_of :name
  validates_presence_of :name
  validates_length_of :teaser, :in=>10...140, :allow_blank => true
  validates_length_of :phone, :in => 7..32, :allow_blank => true
  validates_length_of :fax, :in => 7..32, :allow_blank => true
  
  before_create :set_permalink
  
  def to_param
    [id, permalink].join('-')
  end
  
  ############ PRIVATE ###############    
    private
    def set_permalink
       self.permalink = name.downcase.gsub(/[^0-9a-z]+/, ' ').strip.gsub(' ', '-') if name
    end
  
end
