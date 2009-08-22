Feature: Viewing the home page
  In order to know what I'm getting into
  As a visitor
  I want to be able to see the home page

  Scenario: Display home page with a message.
    Given I am a visitor
    When I go to the homepage
    Then I should see "Hello World"
  
  
  
