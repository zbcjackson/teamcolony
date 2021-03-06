class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      session[:pad_sessions] = {}
      redirect_to root_url, :notice => "Signed in!"
    else
      flash.now.alert = "Invalid email or password"
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    cookies.delete :sessionID, :domain => :all
    redirect_to root_url, :notice => "Signed out!"
  end
  
end
