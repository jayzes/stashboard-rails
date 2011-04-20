class Service < ActiveRecord::Base
  # A service to track
  
  validates :name,        :presence => true, :uniqueness => true
  validates :slug,        :presence => true, :uniqueness => true
  validates :description, :presence => true
    
  has_many :events, :dependent => :destroy, :order => 'created_at DESC'
  
  before_validation_on_create do
    self.slug ||= self.name.parameterize
  end
    
  def current_event
    self.events.first(:order => 'started_at DESC')
  end

  # Specialty function for front page
  def last_five_days
    lowest = Status.default
    severity = lowest.severity
        
    yesterday = date.today() - timedelta(days=1)
    ago = yesterday - timedelta(days=5)
        
    events = self.events.where(:start => (1.day.ago)..(5.days.ago)).limit(100)
    stats = {}
        
    1..5.each do |i|
      stats[yesterday.day] = {
        "image" => lowest.image,
        "day"   => yesterday,
            }
      yesterday = yesterday - timedelta(days=1)
    end
      
    for event in events
      if event.status.severity > severity
        stats[event.start.day]["image"]       = "information"
        stats[event.start.day]["information"] = true
      end
    end

    results = []

    keys = stats.keys()
    keys.sort()
    keys.reverse()

    keys.each do |k|
      results.append(stats[k])
    end
          
    return results
  end
        
        
  def events_for_day(day)
    return self.events.where(:started_at => day.beginning_of_day..day.end_of_day).limit(40)
  end
          
  def compare(other_status)
    0
  end
          
  def resource_url
    "/services/" + self.slug + '.json'
  end
        
  def as_json(options = {})
    base_url = '/api/v1'

    m = {}
    m["name"]         = self.name
    m["id"]           = self.slug
    m["description"]  = self.description
    m["url"]          = base_url + self.resource_url()
    
    event = self.current_event
    if event
      m["current-event"] = event.as_json
    else
      m["current-event"] = nil
    end

    return m
  end
  
end