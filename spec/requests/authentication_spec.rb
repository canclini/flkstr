require 'spec_helper'

describe "Authentication Requests" do

  it "logs in with known user" do
    user = Factory(:user)
    login user
    page.should have_content("Neuigkeiten")
  end
  
  it "should not login with wrong password" do
    user = Factory(:user)
    visit new_user_session_path
    fill_in "Mailadresse", :with => user.email
    fill_in "Password", :with => 'incorrect'
    click_button "Login"
    page.should have_content("Anmelden")
    page.should have_content("Forgot")
  end
  
  it "logs out current user" do
    user = Factory(:user)
    login user
    visit destroy_user_session_path
    page.should have_content("Auf Wiedersehen")
    visit company_path(user.company)
    page.should_not have_content(user.company.name)
  end
end