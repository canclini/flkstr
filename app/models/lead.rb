class Lead < ActiveRecord::Base
  belongs_to :company, :counter_cache => true
  belongs_to :source, :class_name => 'Company'
  belongs_to :request
  
  scope :new_or_accepted, where("status != ?", "declined")
  scope :this_month, where("status = 'accepted' and created_at > ?", Date.new(Time.now.year, Time.now.month, 1)) # accepted leads in current_month
  
  # states (status attribute)
  # new: newly created by system (default)
  # accepted: company has accepted and will see all the details. It does count on its stats
  # declined: company has declined this lead. it does not count on the companies lead statistic
  
  def new?
    status == 'new'
  end
  
  def accepted?
    status == 'accepted'
  end
  
end
