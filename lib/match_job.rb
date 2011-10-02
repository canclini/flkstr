# -*- encoding : utf-8 -*-
class MatchJob < Struct.new(:request_id)  
  def perform  
    request = Request.find(request_id)
    Match.initiate(request)
  end  
end
