Given /^I am logged in as a firefighter$/ do
  User.delete_all
  OrganizationId.delete_all
  OrganizationId.create!(:name=>"AB1234")
  @user = FactoryGirl.create(:user)
  visit "/"
  fill_in "user_email", with: 'email@example.com'
  fill_in "user_password", with: 'foobar'
  click_button "Sign in"
end
