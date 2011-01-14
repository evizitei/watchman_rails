Given /^there is an active organization id of "([^"]*)"$/ do |name|
  OrganizationId.create(:name=>name)
end

Given /^I am subscribed to "([^"]*)"$/ do |apparatus|
  @user.add_subscription!(apparatus)
end