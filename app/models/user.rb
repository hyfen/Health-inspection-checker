class User < ActiveRecord::Base
  
  def cache_checkins
    
    client = Foursquare2::Client.new(:oauth_token => self.foursquare_token)
    self.checkins = Marshal.dump(client.user_venue_history()["items"])
    self.save
    
  end
  
  def cached_checkins
    Marshal.load(self.checkins)
  end
  
  def toronto_food_checkins
    checkins = self.cached_checkins.select{|k|
      k["venue"]["categories"].select{|cat| cat["parents"]==["Food"]}.size > 0
    }
    checkins.select{|k|   
      k["venue"]["location"]["city"] == "Toronto" 
    }
  end
  
end
