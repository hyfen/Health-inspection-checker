class Inspection < ActiveRecord::Base
  belongs_to :establishment
  has_many :infractions
  
  scope :dirty, where(:status => ["Closed", "Conditional Pass"])
  
  def pretty_status 
    case self.status
      when "Pass" then "pass"
      when "Conditional Pass" then "conditional"
      when "Closed" then "fail"
    end
  end
  
end
