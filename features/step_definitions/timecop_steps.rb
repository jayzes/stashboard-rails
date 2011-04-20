Given 'the time is $time' do |time|
  Timecop.freeze Time.parse(time)
end
