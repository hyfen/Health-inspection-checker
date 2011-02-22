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
  
end
