# -*- encoding : utf-8 -*-
class NotificationCreateJob < Struct.new(:company_id, :notifiable)
  def perform
    company = Company.find(company_id)
    for user in company.users.all
      user.notifications.create(:notifiable => notifiable, :schedule => user.notify)
    end
  end
end
