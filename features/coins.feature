Feature: Access crypto data
  Scenario: As a non-logged in user I cannot see the crypto data
    Given I am not logged in
    When I visit coins page
    Then I should be on log in page
    And I should see "Please sign in"
    And I should see "Sign in with GitHub"

  Scenario: As a logged in user I can see the crypto data
    Given I am a logged in user
    When I visit coins page
    Then I should be on coins page
    And I should not see "Please sign in"
    And I should not see "Sign in with GitHub"
    And I should see "Logout"
    And I should see "Code"
    And I should see "Name"
    And I should see "Market Cap"
    And I should see "Value (USD)"