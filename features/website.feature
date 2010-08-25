Feature: Website content is visible
  In order to see what flockstreet is about
  As an user
  I want to see the homepage and its static sites  
  
  Scenario: Visiting the site for the first time
    Given I am on the home page
    Then I should see "Flockstreet für Unternehmen"
    And I should see "Jetzt mitmachen"
    
  Scenario: Reading the Terms & Conditions
    Given I am on the home page
    When I go to Terms & Conditions
    Then I should see "Nutzungsbedingungen"
    
  Scenario: Consulting the FAQ Page
    Given I am on the home page
    When I go to FAQ
    Then I should see "Frequently asked questions"

  Scenario: Looking at the Contact Page
    Given I am on the home page
    When I go to contact
    Then I should see "Kontakt"
  
  Scenario: Looking at the About flockstreet page
    Given I am on the home page
    When I go to about flockstreet
    Then I should see "Über uns"
