@api
Feature: Status JSON service
  As an API user
  Stashboard should
  Provide a resource for interacting with statuses

  Scenario: GET to the statuses resource should return an array of statuses
    Given the following statuses exist:
      | Name  | Description   | Image | Severity  |
      | Good  | I am a status | chain | 10        |
    And I send a GET request for "/api/v1/statuses.json"
    Then the response status should be "200"
    And the JSON response should have "$.statuses[0].description" with the text "I am a status"
    And the JSON response should have "$.statuses[0].level" with the text "NORMAL"
    And the JSON response should have "$.statuses[0].url" with the text "/api/v1/statuses/good.json"
    And the JSON response should have "$.statuses[0].image" with the text "/images/status/chain.png"
    And the JSON response should have "$.statuses[0].id" with the text "good"
    And the JSON response should have "$.statuses[0].name" with the text "Good"
    
  Scenario: POST to the statuses resource should create a new status
    Given I send a POST request to "/api/v1/statuses.json" with the following:
      """
      status[name]=New%20Status&status[description]=I%20am%20a%20new%20status&status[level]=ERROR&status[image]=anchor
      """
    Then the response status should be "201"
    When I send a GET request for "/api/v1/statuses/new-status.json"
    And the JSON response should have "$.description" with the text "I am a new status"
    And the JSON response should have "$.level" with the text "ERROR"
    And the JSON response should have "$.url" with the text "/api/v1/statuses/new-status.json"
    And the JSON response should have "$.image" with the text "/images/status/anchor.png"
    And the JSON response should have "$.id" with the text "new-status"
    And the JSON response should have "$.name" with the text "New Status"
    
  Scenario: GET to an individual status resource should return the details of that status
    Given the following statuses exist:
      | Name  | Description   | Image | Severity  |
      | Good  | I am a status | chain | 10        |
    And I send a GET request for "/api/v1/statuses/good.json"
    Then the response status should be "200"
    And the JSON response should have "$.description" with the text "I am a status"
    And the JSON response should have "$.level" with the text "NORMAL"
    And the JSON response should have "$.url" with the text "/api/v1/statuses/good.json"
    And the JSON response should have "$.image" with the text "/images/status/chain.png"
    And the JSON response should have "$.id" with the text "good"
    And the JSON response should have "$.name" with the text "Good"
    
  Scenario: PUT to an individual status resource should update that status
    Given the following statuses exist:
      | Name  | Description   | Image | Severity  |
      | Good  | I am a status | chain | 10        |
    When I send a PUT request to "/api/v1/statuses/good.json" with the following:
      """
      status[description]=I%20am%20a%20different%20status
      """
    Then the response status should be "200"
    When I send a GET request for "/api/v1/statuses/good.json"
    And the JSON response should have "$.description" with the text "I am a different status"
    
  @allow-rescue
  Scenario: DELETE to an individual status resource should delete that status
    Given the following statuses exist:
      | Name  | Description   | Image | Severity  |
      | Good  | I am a status | chain | 10        |
    And I send a DELETE request to "/api/v1/statuses/good.json"
    Then the response status should be "200"
    When I send a GET request for "/api/v1/statuses/good.json"
    Then the response status should be "404"