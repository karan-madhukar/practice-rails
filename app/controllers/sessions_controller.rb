class SessionsController < ApplicationController

  def new
    redirect_to root_path if logged_in
  end

  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to root_path, flash: { success: "logged in successfully!" }
    else
      redirect_to login_path, flash: { danger: "wrong password or email!" }
    end
  end

  def destroy
    reset_session
    redirect_to root_path, flash: { success: "logged out successfully!" }
  end

  def error

  end

end
