@api
Feature: Events JSON service
  As an API user
  Stashboard should
  Provide a resource for interacting with service events
  
  Background:
    Given the time is Jan 1 2011, 10:00 MST
    And the following services exist:
      | Name  | Description         |
      | DNS  | I serve DNS requests |
    And the following statuses exist:
      | Name  | Description   | Image | Severity  |
      | Good  | I am a status | chain | 10        |

  Scenario: GET to the service events resource should return an array of events
    Given the following events exist:
      | Service   | Status      | Message           |
      | Name: DNS | Name: Good  | Everything's cool |
    And I send a GET request for "/api/v1/services/dns/events.json"
    Then the response status should be "200"
    And show me the response
    And the JSON response should have "$.events[0].sid" with the text "1"
    And the JSON response should have "$.events[0].message" with the text "Everything's cool"
    And the JSON response should have "$.events[0].timestamp" with the text "Sat, 01 Jan 2011 17:00:00 +0000"
    And the JSON response should have "$.events[0].url" with the text "/api/v1/services/dns/events/1.json"
    And the JSON response should have "$.events[0].status.id" with the text "good"
    And the JSON response should have "$.events[0].status.name" with the text "Good"
    And the JSON response should have "$.events[0].status.description" with the text "I am a status"
    And the JSON response should have "$.events[0].status.level" with the text "NORMAL"
    And the JSON response should have "$.events[0].status.image" with the text "/images/status/chain.png"
    And the JSON response should have "$.events[0].status.url" with the text "/api/v1/statuses/good.json"
    
  Scenario: POST to the service events resource should create a new event
    Given I send a POST request to "/api/v1/services/dns/events.json" with the following:
      """
      event[status]=good&event[message]=I%20am%20a%20new%20message
      """
    Then the response status should be "201"
    When I send a GET request for "/api/v1/services/dns/events/1.json"
    And the JSON response should have "$.message" with the text "I am a new message"
    And the JSON response should have "$.status.id" with the text "good"
  
  Scenario: GET to the current service event resource should return the current event
    Given the following events exist:
      | Service   | Status      | Message           |
      | Name: DNS | Name: Good  | Everything's cool |
    And I send a GET request for "/api/v1/services/dns/events/current.json"
    And show me the response
    Then the response status should be "200"
    And the JSON response should have "$.sid" with the text "1"
    And the JSON response should have "$.message" with the text "Everything's cool"
    And the JSON response should have "$.timestamp" with the text "Sat, 01 Jan 2011 17:00:00 +0000"
    And the JSON response should have "$.url" with the text "/api/v1/services/dns/events/1.json"
    And the JSON response should have "$.status.id" with the text "good"
    And the JSON response should have "$.status.name" with the text "Good"
    And the JSON response should have "$.status.description" with the text "I am a status"
    And the JSON response should have "$.status.level" with the text "NORMAL"
    And the JSON response should have "$.status.image" with the text "/images/status/chain.png"
    And the JSON response should have "$.status.url" with the text "/api/v1/statuses/good.json"
    
  Scenario: GET to an individual service event resource should return the details of that event
    Given the following events exist:
      | Service   | Status      | Message           |
      | Name: DNS | Name: Good  | Everything's cool |
    And I send a GET request for "/api/v1/services/dns/events/1.json"
    And show me the response
    Then the response status should be "200"
    And the JSON response should have "$.sid" with the text "1"
    And the JSON response should have "$.message" with the text "Everything's cool"
    And the JSON response should have "$.timestamp" with the text "Sat, 01 Jan 2011 17:00:00 +0000"
    And the JSON response should have "$.url" with the text "/api/v1/services/dns/events/1.json"
    And the JSON response should have "$.status.id" with the text "good"
    And the JSON response should have "$.status.name" with the text "Good"
    And the JSON response should have "$.status.description" with the text "I am a status"
    And the JSON response should have "$.status.level" with the text "NORMAL"
    And the JSON response should have "$.status.image" with the text "/images/status/chain.png"
    And the JSON response should have "$.status.url" with the text "/api/v1/statuses/good.json"
    
  @allow-rescue
  Scenario: DELETE to an individual service event resource should delete that event
    Given the following events exist:
      | Service   | Status      | Message           |
      | Name: DNS | Name: Good  | Everything's cool |
    And I send a DELETE request to "/api/v1/services/dns/events/1.json"
    Then the response status should be "200"
    When I send a GET request for "/api/v1/services/dns/events/1.json"
    Then the response status should be "404"