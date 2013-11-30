Given /^I am logged in as a firefighter$/ do 
  OrganizationId.create!(:name=>"AB1234")
  @user = Factory(:user)
  When %Q{I go to the login page}
  And  %Q{I fill in "user_email" with "email@example.com"}
  And  %Q{I fill in "user_password" with "foobar"}
  And  %Q{I press "Sign in"}
end
