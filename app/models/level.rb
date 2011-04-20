class Level

  NORMAL    = "NORMAL"
  WARNING   = "WARNING"
  ERROR     = "ERROR"
  CRITICAL  = "CRITICAL"

  LEVELS = ActiveSupport::OrderedHash.new
  
  LEVELS[NORMAL] = 10
  LEVELS[WARNING] = 30
  LEVELS[ERROR] = 40
  LEVELS[CRITICAL] = 50

  def self.get_severity(level)
    LEVELS[level]
  end
  
  def self.get_level(severity)
    LEVELS.invert[severity]
  end
    
  def self.all
    Level::LEVELS
  end

end