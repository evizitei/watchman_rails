Feature: choose my apparatus
  As a firefighter
  I want to manage which apparatus I'm subscribed to
  In order to minimize the number of extra messages I get
  
  Scenario: adding trucks
    Given I am logged in as a firefighter
    When I select "E1401" from "apparatus"
      And I press "subscribe"
    Then I should be on the my account page
      And I should see "E1401" within "#my_subscriptions"
      And I should not see "E801" within "#my_subscriptions"