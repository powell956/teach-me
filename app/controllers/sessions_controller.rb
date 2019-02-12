class SessionsController < ApplicationController
  skip_before_action :authorize, only: [:login, :create]

  def login
    render :layout => false
  end

  def create
   @user = User.find_by(username: params[:username])
   # return head(:forbidden) unless @user.authenticate(params[:password])
   if @user && @user.authenticate(params[:password])
     session[:user_id] = @user.id
     redirect_to @user
   else
     flash[:message] = "Username or password is invalid"
     redirect_to '/login'
   end
  end

  def destroy
    session.delete(:user_id)
    redirect_to '/login'
  end


end
