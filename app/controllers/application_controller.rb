class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :current_user
  
  def current_user
    redirect_to start_oauth_url unless session[:current_user_id]
    @current_user ||= session[:current_user_id] &&
      User.find(session[:current_user_id])
  end
  
end
