class User < ActiveRecord::Base
  
  def cache_checkins
    
    client = Foursquare2::Client.new(:oauth_token => self.foursquare_token)
    self.checkins = Marshal.dump(client.user_checkins)
    save
    
  end
  
  def cached_checkins
    Marshal.load(self.checkins)
  end
  
end
