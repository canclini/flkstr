# -*- encoding : utf-8 -*-
class Company < ActiveRecord::Base
  has_many :locations
end
