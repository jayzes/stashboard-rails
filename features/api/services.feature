@api
Feature: Services JSON service
  As an API user
  Stashboard should
  Provide a resource for interacting with services

  Scenario: GET to the services resource should return an array of services
    Given the following services exist:
      | Name  | Description         |
      | DNS  | I serve DNS requests |
    And I send a GET request for "/api/v1/services.json"
    Then the response status should be "200"
    And the JSON response should have "$.services[0].name" with the text "DNS"
    And the JSON response should have "$.services[0].id" with the text "dns"
    And the JSON response should have "$.services[0].description" with the text "I serve DNS requests"
    And the JSON response should have "$.services[0].url" with the text "/api/v1/services/dns.json"
    
  Scenario: POST to the services resource should create a new service
    Given I send a POST request to "/api/v1/services.json" with the following:
      """
      service[name]=New%20Service&service[description]=I%20am%20a%20new%20service
      """
    Then the response status should be "201"
    When I send a GET request for "/api/v1/services/new-service.json"
    And the JSON response should have "$.name" with the text "New Service"
    And the JSON response should have "$.id" with the text "new-service"
    And the JSON response should have "$.description" with the text "I am a new service"
    And the JSON response should have "$.url" with the text "/api/v1/services/new-service.json"
    
  Scenario: GET to an individual service resource should return the details of that service
    Given the following services exist:
      | Name  | Description     |
      | DNS   | I am a service  |
    And I send a GET request for "/api/v1/services/dns.json"
    Then the response status should be "200"
    And the JSON response should have "$.name" with the text "DNS"
    And the JSON response should have "$.id" with the text "dns"
    And the JSON response should have "$.description" with the text "I am a service"
    And the JSON response should have "$.url" with the text "/api/v1/services/dns.json"

  Scenario: PUT to an individual service resource should update that service
    Given the following services exist:
      | Name  | Description     |
      | DNS   | I am a service  |
    When I send a PUT request to "/api/v1/services/dns.json" with the following:
      """
      service[description]=I%20am%20a%20different%20service
      """
    Then the response status should be "200"
    When I send a GET request for "/api/v1/services/dns.json"
    And the JSON response should have "$.description" with the text "I am a different service"
    
  @allow-rescue
  Scenario: DELETE to an individual status resource should delete that status
    Given the following services exist:
      | Name  | Description     |
      | DNS   | I am a service  |
    And I send a DELETE request to "/api/v1/services/dns.json"
    Then the response status should be "200"
    When I send a GET request for "/api/v1/services/dns.json"
    Then the response status should be "404"