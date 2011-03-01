class CheckinsController < ApplicationController
  
  def check
    debugger
    @user = User.find(5)
    @checkins = @user.toronto_food_checkins
    @establishments = []
    for checkin in @checkins
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
  
  def test
    render :text => params
  end
  
end
