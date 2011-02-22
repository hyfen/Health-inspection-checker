class Inspection < ActiveRecord::Base
  belongs_to :establishment
  has_many :infractions
  
  scope :dirty, where(:status => ["Closed", "Conditional Pass"])
  
end
