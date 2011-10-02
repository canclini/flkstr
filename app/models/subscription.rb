# -*- encoding : utf-8 -*-
class Subscription < ActiveRecord::Base
  belongs_to :company
  belongs_to :plan
  attr_accessor(:ccNumber, :ccCardCode, :month, :year, :ccFirstName, :ccLastName, :ccZip)
end
