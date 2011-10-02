# -*- encoding : utf-8 -*-
class Plan < ActiveRecord::Base
  NAMES = %w[ready connect scale]  
  
  def notifications_allowed?
    name != "ready"
  end
  
end
