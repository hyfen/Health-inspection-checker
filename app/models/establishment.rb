class Establishment < ActiveRecord::Base
  has_many :inspections
  belongs_to :location, :primary_key => "address", :foreign_key => "address"
  
  def past_infractions
    infractions = []
    self.inspections.dirty.each do |inspection|
      infractions += inspection.infractions
    end
    return infractions
  end
  
  def dirty?
    self.inspections.dirty.size > 0
  end
  
  def fuzzy_address
    self.location.address.split(" ")[0..1].join(" ")
  end
  
  def geocoded?
    self.location != nil and self.location.geocoded?
  end
  
end
