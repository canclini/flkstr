# -*- encoding : utf-8 -*-
class Store < ActiveRecord::Base
  acts_as_mappable :auto_geocode => true
end
