# -*- encoding : utf-8 -*-
class Feed < ActiveRecord::Base
  belongs_to :feed_item
  belongs_to :company
end
