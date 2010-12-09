class UserMailer < ActionMailer::Base
  default :from => "register@flockstreet.com"
  
  def registration_confirmation(user)
    @user = user
    @company = @user.company
    mail(:to => user.email, :subject => "Erfolgreich registriert!")
  end
  
  def beta_registration_confirmation(user)
    @user = user
    @company = @user.company
    mail(:to => user.email, :subject => "Erfolgreich fuer die Beta Phase registriert!")
  end
  
end
