class CheckinsController < ApplicationController

  
  def check
    # crude testing code. Check the first user's foursquare history against dinesafe info
    @checkins = @current_user.toronto_food_checkins
    @establishments = []
    @checkins.each do |checkin|
      address = checkin["venue"]["location"]["address"]
      name = checkin["venue"]["name"]
      if address and name
        e = Establishment.search(address + " " + name, :match_mode => :any)
        unless e.empty?
          @establishments << [checkin, e.first]
        end
      end
    end
    
  end
    
end
