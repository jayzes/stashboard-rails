Then /^the JSON response should have "([^\"]*)" appear (\d+) times$/ do |json_path, times|
  json    = JSON.parse(page.driver.last_response.body)
  results = JsonPath.new(json_path).on(json).to_a
  if page.respond_to? :should
    results.size.should == times.to_i
  else
    assert_equal times.to_i, results.size
  end
end
