class ApplicationController < ActionController::Base
  helper_method :current_user
  before_action :authorize

  def authorize
    redirect_to '/login' unless logged_in?
  end

  def logged_in?
    !!current_user
  end

  def current_user
    User.find_by(id: session[:user_id])
  end

end
