# -*- encoding : utf-8 -*-
class Tag < ActiveRecord::Base

  def as_json(options = {})    
    {
      :id => id,
      :value => name
    }.as_json(options)
  end    
  
end
