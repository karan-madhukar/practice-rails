class UsersController < ApplicationController
    
  def index
    @article = Article.all   
  end

  def new
    redirect_to root_path if logged_in
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, flash: { success: "logged in successfully!" }
    else
      render "new"
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
