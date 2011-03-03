class User < ActiveRecord::Base
  
  def cache_checkins
    
    client = Foursquare2::Client.new(:oauth_token => self.foursquare_token)
    self.checkins = Base64.encode64(Marshal.dump(client.user_venue_history()["items"]))
    self.save
    
  end
  
  def cached_checkins
    Marshal.load(Base64.decode64(self.checkins))
  end
  
  def toronto_food_checkins
    checkins = self.cached_checkins.select do |k|
      k["venue"]["categories"].select{|cat| cat["parents"]==["Food"]}.size > 0
    end
    checkins.select do |k|   
      k["venue"]["location"]["city"] == "Toronto" 
    end
  end
  
  def get_foursquare_name
    client = Foursquare2::Client.new(:oauth_token => self.foursquare_token) 
    c = client.user("self")
    self.update_attribute("name", c["firstName"] + " " + c["lastName"])
  end
  
end