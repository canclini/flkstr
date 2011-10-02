# -*- encoding : utf-8 -*-
class User < ActiveRecord::Base
  has_secure_password
  # Setup accessible (or protected) attributes for your model
  attr_accessible :firstname, :lastname, :language, :email, :password, :password_confirmation, :remember_me, :notify, :notifiers, :terms_of_service
  before_create { generate_token(:auth_token) }
  
  belongs_to :company
  has_many :notifications
  validates_length_of :phone, :in => 7..32, :allow_blank => true
  validates_presence_of :password, :on => :create
  validates_length_of :password, :minimum => 4, :on => :create, :too_short => "zu kurz (mindestens 4 Zeichen)"
  validates :email, :presence => true, :uniqueness => true, :email_format => true
  validates_acceptance_of :terms_of_service
  
  NOTIFY = %w[immediate daily weekly] # one to many association; see Railscasts 189
  NOTIFIERS = %w[leads messages network] # many to many association; see Railscasts 189
  
  
  def notify_symbols
    [notify.to_sym]
  end
  
  def notifiers_symbols
    notifiers.map(&:to_sym)
  end
  
  def notifiers=(notifiers) # setter method for the notifiers. will be saved as a bitmap
    self.notifiers_mask = (notifiers & NOTIFIERS).map { |n| 2**NOTIFIERS.index(n) }.sum
  end
  
  def notifiers # getter method for the notifiers.
    NOTIFIERS.reject { |n| ((notifiers_mask || 0) & 2**NOTIFIERS.index(n)).zero? }
  end
  
  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver
  end
  
  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end
  
  def fullname
    if firstname? and lastname? then
      lastname.capitalize + " " + firstname.capitalize
    else
      email
    end
  end
end
