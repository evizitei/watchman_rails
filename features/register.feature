Feature: signing up as a new user
  As a firefighter
  I want to be able to create an account with watchman
  In order to get sms pages about calls

Scenario: Signing Up
  Given I am on the signup page 
  Then I fill in "user_email" with "ethan.vizitei@gmail.com" 
  And I fill in "user_password" with "firedistrict" 
  And I fill in "user_password_confirmation" with "firedistrict"
  And I fill in "user_phone" with "15732395840" 
  And I press "Sign up"
  Then I should be on my account page