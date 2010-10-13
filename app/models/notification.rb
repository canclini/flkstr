class Notification < ActiveRecord::Base
  belongs_to :notifiable, :polymorphic => true
  belongs_to :user
  
  scope :to_send, where("status = ?",'new').order("created_at ASC")
  scope :processing, where("status = ?",'processing').order("created_at ASC")
  scope :daily, where("schedule = ?",'daily').order("created_at ASC")
  scope :immediate, where("schedule = ?",'immediate').order("created_at ASC")
  scope :weekly, where("schedule = ?",'weekly').order("created_at ASC")
  
  scope :leads, where("notifiable_type = ?", "Lead")
  scope :messages, where("notifiable_type = ?", "MessageCopy")
  
#  after_create :send_on_immediate
  
  def self.schedule_daily
    daily.to_send.group(:user_id).collect(&:user_id).each do |user_id|
      Delayed::Job.enqueue(GroupNotifyJob.new(user_id))  
    end    
  end

  def self.schedule_weekly
    weekly.to_send.group(:user_id).collect(&:user_id).each do |user_id|
      Delayed::Job.enqueue(GroupNotifyJob.new(user_id))  
    end    
  end
  
  private
  
  def send_on_immediate
    if self.immediate == 'immediate'
#      Delayed::Job.enqueue(NotifyJob.new(self.user, self.notifiable))  
    end
  end
  
end
