Then /(?:|I )debug/ do
  debugger
  true
end

Then /(?:|I )sleep a while/ do
  Then('I sleep for 5 seconds')
end

Then /(?:|I )sleep forever/ do
  Then('I sleep for 600 seconds')
end

Then /(?:|I )pause for a second/ do
  Then('I sleep for 1 seconds')
end

Then /(?:|I )sleep for (\d*) seconds?/ do |seconds|
  sleep seconds.to_i
end