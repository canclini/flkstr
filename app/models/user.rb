class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :firstname, :lastname, :language, :email, :password, :password_confirmation, :remember_me
  
  belongs_to :company
  validates_length_of :phone, :in => 7..32, :allow_blank => true
  
  def fullname
    if firstname? and lastname? then
      lastname.capitalize + " " + firstname.capitalize
    else
      email
    end
  end
    
end
