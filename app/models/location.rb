class Location < ActiveRecord::Base
  has_many :establishments
  
  scope :geocoded, where("lat IS NOT null AND locations.long IS NOT null")
  
  def geocoded?
    self.lat != nil and self.long != nil
  end
  
end
