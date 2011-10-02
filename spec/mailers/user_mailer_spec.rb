# -*- encoding : utf-8 -*-
require "spec_helper"

describe UserMailer do
  describe "password reset" do
    let(:user) { Factory(:user, :password_reset_token => "anything") }
    let(:mail) { UserMailer.password_reset(user) }

    it "send user password reset url" do
      mail.subject.should eq("Password Reset")
      mail.to.should eq([user.email])
      mail.from.should eq(["register@flockstreet.com"])
      mail.body.encoded.should match(edit_password_reset_path(user.password_reset_token))
    end
  end
  
  describe "registration confirmation" do
    let(:user) { Factory(:user) }
    let(:mail) { UserMailer.registration_confirmation(user) }

    it "send user password reset url" do
      mail.subject.should eq("Erfolgreich registriert!")
      mail.to.should eq([user.email])
      mail.from.should eq(["register@flockstreet.com"])
      mail.body.encoded.should match(user.company.name)
    end
  end
  
end
