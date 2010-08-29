Then /^I should see the name of #{capture_model}$/ do | modelname|
  search = model!(modelname).name  
  Then %{I should see "#{search}"}
end

Then /^I should not see the name of #{capture_model}$/ do | modelname|
  search = model!(modelname).name
  Then %{I should not see "#{search}"}
end