class Status < ActiveRecord::Base
  
  has_many :events, :dependent => :destroy
  
  validates :name,        :presence => true, :uniqueness => true
  validates :slug,        :presence => true, :uniqueness => true
  validates :description, :presence => true
  validates :image,       :presence => true
  validates :severity,    :presence => true   # Should probably be a relationship to level
  
  before_validation_on_create do
    self.slug ||= (self.name || '').parameterize
  end
  
  def level
    Level.get_level(self.severity)
  end

  def level=(level)
    self.severity = Level.get_severity(level)
  end
  
  def self.default
    # Return the first status with a NORMAL level.
    normal = Level.get_severity(Level::NORMAL)
    where(:severity => normal).first
  end
    
  def image_url
    "/images/status/#{image}.png"
  end

  def resource_url
    "/statuses/#{slug}.json"
  end

  def as_json(options = {})
    base_url = '/api/v1'
    
    m = {}
    m["name"]         = self.name
    m["id"]           = self.slug
    m["description"]  = self.description
    m["level"]        = self.level
    m["url"]          = base_url + self.resource_url
    m["image"]        = self.image_url # Not a direct port, but may work
    m
  end

end