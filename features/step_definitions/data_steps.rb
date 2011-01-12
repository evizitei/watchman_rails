Given /^there is an active organization id of "([^"]*)"$/ do |name|
  OrganizationId.create(:name=>name)
end
