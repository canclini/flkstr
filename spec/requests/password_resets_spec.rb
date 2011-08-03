require 'spec_helper'

describe "PasswordResets" do
  it "emails user when requesting password reset" do
    user = Factory(:user)
    visit login_path
    click_link "password"
    within(:xpath, "//div[@class='green_box']") do
      fill_in "Mailadresse", :with => user.email
    end
    click_button "Reset Password"
    current_path.should eq(new_user_session_path)
    #page.should have_content("versendet")
    last_email.to.should include(user.email)
  end

 it "does not email invalid user when requesting password reset" do
   visit login_path
   click_link "password"
   within(:xpath, "//div[@class='green_box']") do
     fill_in "Mailadresse", :with => "nobody@example.com"
   end
   click_button "Reset Password"
   #current_path.should eq(new_user_session_path)
   #page.should have_content("Email sent")
   last_email.should be_nil
 end

#  it "updates the user password when confirmation matches" do
#    user = Factory(:user, :password_reset_token => "something", :password_reset_sent_at => 1.hour.ago)
#    visit edit_password_reset_path(user.password_reset_token)
#    fill_in "Password", :with => "foobar"
#    click_button "Update Password"
#    page.should have_content("Password doesn't match confirmation")
#    fill_in "Password", :with => "foobar"
#    fill_in "Password confirmation", :with => "foobar"
#    click_button "Update Password"
#    page.should have_content("Password has been reset")
#  end
#
#  it "reports when password token has expired" do
#    user = Factory(:user, :password_reset_token => "something", :password_reset_sent_at => 5.hour.ago)
#    visit edit_password_reset_path(user.password_reset_token)
#    fill_in "Password", :with => "foobar"
#    fill_in "Password confirmation", :with => "foobar"
#    click_button "Update Password"
#    page.should have_content("Password reset has expired")
#  end
#
#  it "raises record not found when password token is invalid" do
#    lambda {
#      visit edit_password_reset_path("invalid")
#    }.should raise_exception(ActiveRecord::RecordNotFound)
#  end
end