# -*- encoding : utf-8 -*-
require 'spec_helper'


# UseCases: 
# UC n6, UCn6-Sich_anmelden.odt
# UC n10, UCn10-Sich_abmelden.odt

# describes authentication, password resets etc...


describe "Authentication Requests" do
  subject { create(:user) }
  
  context "when logged out" do
    before { visit logout_path }

    #normal flow
    it "logs in with known user" do
      login subject
      current_path.should eq(dashboard_path)
      page.should have_content("Neuigkeiten")
    end
    
    # e1
    it "should not login with wrong password" do
      visit login_path
      fill_in "email", :with => subject.email
      fill_in "password", :with => 'incorrect'
      click_button "Login"
      page.should have_content("Anmelden")
      page.should have_content("Passwort vergessen?")
    end
  end
    
  context "when logged in" do
    before { login subject }
    
    it "logs out current user" do
      visit logout_path
      page.should have_content("Auf Wiedersehen")
      visit company_path(subject.company)
      page.should_not have_content(subject.company.name)
    end
    
    it "logs out current user when trying to login" do
      visit login_path
      visit company_path(subject.company)
      page.should_not have_content(subject.company.name)
    end
  end
end

describe "PasswordResets" do
  # e2  

  it "emails user when requesting password reset" do
    user = create(:user)
    visit login_path
    click_link "Passwort vergessen"
    within(:xpath, "//div[@class='green_box']") do
      fill_in "email", :with => user.email
    end
    click_button "Reset Password"
    current_path.should eq(root_path)
    page.should have_content("E-Mail mit Instruktionen versendet")
    last_email.to.should include(user.email)
  end
  
  it "updates the user password when confirmation matches" do
    user=create(:user, :password_reset_token => "something", :password_reset_sent_at => 1.hour.ago)
    visit edit_password_reset_path(user.password_reset_token)
    fill_in "Password", :with => "foobar"
    click_button "Update Password"
    page.should have_content("Password stimmt nicht")
    fill_in "Password", :with => "foobar"
    fill_in "Password confirmation", :with => "foobar"
    click_button "Update Password"
    page.should have_content("Password has been reset")
  end
   
 it "does not email invalid user when requesting password reset" do
   visit login_path
   click_link "Passwort vergessen"
   within(:xpath, "//div[@class='green_box']") do
     fill_in "email", :with => "nobody@example.com"
   end
   click_button "Reset Password"
   current_path.should eq(new_password_reset_path)
   page.should have_content("E-Mail Adresse nicht bekannt")
   last_email.should be_nil
 end

 it "reports when password token has expired" do
   user = create(:user, :password_reset_token => "something", :password_reset_sent_at => 5.hour.ago)
   visit edit_password_reset_path(user.password_reset_token)
   fill_in "Password", :with => "foobar"
   fill_in "Password confirmation", :with => "foobar"
   click_button "Update Password"
   page.should have_content("Password reset has expired")
 end
 
 it "raises record not found when password token is invalid" do
   lambda {
     visit edit_password_reset_path("invalid")
   }.should raise_exception(ActiveRecord::RecordNotFound)
 end
end
