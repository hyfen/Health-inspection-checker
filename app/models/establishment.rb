class Establishment < ActiveRecord::Base
  has_many :inspections
  belongs_to :location, :primary_key => "address", :foreign_key => "address"
end
