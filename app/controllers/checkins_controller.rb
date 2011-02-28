class CheckinsController < ApplicationController
  
  def check
    @user = User.first
    @checkins = @user.food_checkins
    @establishments = []
    for checkin in @checkins
      address = checkin["venue"]["location"]["address"]
      name = checkin["venue"]["name"]
      e = Establishment.search(address + " " + name, :match_mode => :any)[0]
      unless 
        @establishments << e
      end
    end
  end
  
end
