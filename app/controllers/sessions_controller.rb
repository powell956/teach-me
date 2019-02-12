class SessionsController < ApplicationController
  skip_before_action :authorize, only: [:login, :create]

  def login

  end

  def create
   @user = User.find_by(username: params[:username])
   return head(:forbidden) unless @user.authenticate(params[:password])
   session[:user_id] = @user.id
   redirect_to '/dashboard'
  end

  def destroy
    session.delete(:user_id)
    redirect_to '/login'
  end


end
