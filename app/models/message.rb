# -*- encoding : utf-8 -*-
class Message < ActiveRecord::Base
    belongs_to :author, :class_name => "Company"
    has_many :message_copies
    has_many :recipients, :through => :message_copies

    before_create :prepare_copies

    paginates_per 10;

    attr_accessor :to # array od recipients
    attr_accessible :subject, :body, :to

    def prepare_copies
      return if to.blank?
      # works only for single recipients
      recipient = Company.find_by_name(to)
      message_copies.build(:recipient_id => recipient.id)
    end
end
