@api
Feature: Status Images JSON service
  As an API user
  Stashboard should
  Provide a list of status images in JSON format

  Scenario: Return an array of status images
    Given I send a GET request for "/api/v1/status_images.json"
    Then the response status should be "200"
    And the JSON response should have "$..name" appear 2627 times
    And the JSON response should have "$.images[0].name" with the text "address-book--arrow"
    And the JSON response should have "$.images[0].url" with the text "/images/status/address-book--arrow.png"