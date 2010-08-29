@wip
Feature: User Authentication
  In order to get money from companies
  a user must be able to sign up, log in, log out 
  
  Scenario: user login
    Given a user exists
    When that user logs in
    Then I should be on the dashboard