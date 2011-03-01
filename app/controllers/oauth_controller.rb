class OauthController < ApplicationController
  def start
    puts callback_oauth_url
    redirect_to client.web_server.authorize_url(:redirect_uri => callback_oauth_url, :response_type => "code")
  end

  def callback
    @a = client.web_server.get_access_token(
      params[:code], :redirect_uri => callback_oauth_url
    )
    
    # just save the token to a new user for now until session handling code is written
    u = User.new
    u.foursquare_token = @a.token
    u.save
  end

  protected

  def client
    @client ||= OAuth2::Client.new(
      'KIDQ2MR5FMI2IGVIQTD35O5A0G4YQNPSC1B1SPVPRSGMJOWK', '5ZXAG5N4KGAVHTKXBKL4A1T0SIGEQYKGRANWMJ3N2SCBYUNO', :site => 'https://foursquare.com/oauth2', :authorize_path => "/oauth2/authenticate", :access_token_path => "/oauth2/access_token"
    )
  end
end