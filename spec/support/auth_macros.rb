module AuthMacros
  def login(user = nil)
    user ||= Factory(:user)
    visit login_path
    within(:xpath, "//div[@class='green_box']") do
      fill_in "email", :with => user.email
      fill_in "password", :with => user.password
    end
    click_button "Anmelden"
    @_current_user = user
  end

  def current_user
    @_current_user
  end
end