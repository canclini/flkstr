Feature: Company Profile view
  In order to find other companies
  As an user
  I want to see the profile of the company
  
  Scenario: Watch the companies profile as an registered user
    Given a company exists with name: "foobar"
    When I go to the show page for that company
    Then I should see "foobar"

#  Scenario: Not possible to watch de companies as a guest
#    Given a guest
#    And a company exists
#    When I go to the companies profile
#    Then I should see "Nur angemeldete User"
  
  
