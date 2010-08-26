Then /^I should see the name of #{capture_model}$/ do | modelname|
  search = model!(modelname).name
  if page.respond_to? :should
    page.should have_xpath('//*', :text => search)
  else
    assert page.has_xpath?('//*', :text => search)
  end
end