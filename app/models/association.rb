class Association < ActiveRecord::Base
  belongs_to :company
  belongs_to :associate, :class_name => 'Company'  
    
  TYPES = %w[partner kunde lieferant konzern]  

  def type_symbols  
    [role.to_sym]  
  end
  
end
