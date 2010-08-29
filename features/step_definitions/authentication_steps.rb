
Given /^a guest$/ do
  visit "/users/sign_out"
end

Given /^a logged in user$/ do
  create_model(user)
  login_as(user)
end

When /^(.+) logs in$/ do |usermodel|
  user = model(usermodel)
  logger.debug "GAGA"
  logger.debug user.email
  Given %{I go to login}
  And %{I fill in "user_email" with "wilhelm@glover.uk"}
  And %{I fill in "user_password" with "password"}
  And %{I press "Sign in"}
  Then %{I should see "Signed in successfully"}
  #Then %{show me the page}
end


