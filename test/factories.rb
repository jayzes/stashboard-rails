Factory.define(:status) do |f|
  f.sequence(:name) { |n| "Status #{n}" }
  f.description     'I am a status'
  f.image           'chain'
  f.severity        10
end

Factory.define(:service) do |f|
  f.sequence(:name) { |n| "Service #{n}" }
  f.description     'I am a service'
end

Factory.define(:event) do |f|
  f.association :status
  f.association :service
  f.started_at  { Time.now }
  f.message     "Something is wrong!"
end