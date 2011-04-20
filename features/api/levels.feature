@api
Feature: Levels JSON service
  As an API user
  Stashboard should
  Provide a list of levels in JSON format

  Scenario: Return an array of levels
    Given I send a GET request for "/api/v1/levels.json"
    Then the response status should be "200"
    And the JSON response should have "$.levels[0]" with the text "NORMAL"
    And the JSON response should have "$.levels[1]" with the text "WARNING"
    And the JSON response should have "$.levels[2]" with the text "ERROR"
    And the JSON response should have "$.levels[3]" with the text "CRITICAL"