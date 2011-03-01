class OauthController < ApplicationController
  def start
    puts callback_oauth_url
    redirect_to client.web_server.authorize_url(:redirect_uri => APP_CONFIG["foursquare_callback_url"], :response_type => "code")
  end

  def callback
    @a = client.web_server.get_access_token(
      params[:code], :redirect_uri => APP_CONFIG["foursquare_callback_url"]
    )
    
    # just save the token to a new user for now until session handling code is written
    u = User.new
    u.foursquare_token = @a.token
    u.save
  end

  protected

  def client
    @client ||= OAuth2::Client.new(
      APP_CONFIG["foursquare_client_id"], 
      APP_CONFIG["foursquare_client_secret"], 
      :site => 'https://foursquare.com/oauth2', 
      :authorize_path => "/oauth2/authenticate", 
      :access_token_path => "/oauth2/access_token"
    )
  end
end