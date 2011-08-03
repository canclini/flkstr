module AuthMacros
  def login(user = nil)
    user ||= Factory(:user)
    visit login_path
    fill_in "Mailadresse", :with => user.email
    fill_in "Password", :with => user.password
    click_button "Login"
    @_current_user = user
  end

  def current_user
    @_current_user
  end
end