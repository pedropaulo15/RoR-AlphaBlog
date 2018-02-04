class SessionsController < ApplicationController

  def new
    
  end
  
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    # Check if there is a user with the entered details, and tries to authenticate the password
    # If it is okay, the user id will be saved in the session, a message will display and the 
    # user will be redirected to the user's profile 
    if user && user.authenticate(params[:session][:password])
      #saving the user id in the session
      session[:user_id] = user.id
      
      flash[:success] = "You have successfully logged in"
      redirect_to user_path(user)
    else
      flash.now[:danger] = "There was something wrong with your login details."
      render 'new'
    end
  end
  
  def destroy
    session[:user_id] = nil
    flash[:success] = "You have Logged out."
    redirect_to root_path
  end
  
end
