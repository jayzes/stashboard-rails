class Event < ActiveRecord::Base
  
  validates :started_at,  :presence => true
  validates :message,     :presence => true
  validates :status,      :presence => true
  
  belongs_to :status
  belongs_to :service
  
  before_validation_on_create do
    self.started_at ||= Time.now
    self.status     ||= Status.default
  end
  
  def status=(value)
    if value.is_a?(String)
      self.status_id = Status.find_by_slug!(value).id
    elsif value.is_a?(Status)
      self.status_id = value.id
    else
      self.status_id = nil
    end
  end
            
  def resource_url
    self.service.resource_url.gsub('.json','') + "/events/" + self.to_param + '.json'
  end
  
  def as_json(options = {})
    base_url = '/api/v1'
    m = {}
    m["sid"]            = self.to_param
    m["timestamp"]      = self.started_at.to_s(:rfc822)
    m["status"]         = self.status.as_json
    m["message"]        = self.message
    m["url"]            = base_url + self.resource_url
    m['informational']  = self.is_informational?
    m
  end

end