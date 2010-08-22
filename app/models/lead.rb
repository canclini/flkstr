class Lead < ActiveRecord::Base
  belongs_to :company, :counter_cache => true
  belongs_to :source, :class_name => 'Company'
  belongs_to :request
  
end
