module SessionsHelper

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in
    !!current_user
  end

  def require_admin
    unless logged_in && current_user.admin
      redirect_to error_path, flash: { danger: "only admin can do this action!"}
    end
  end

  def require_user
    unless logged_in 
      redirect_to login_path, flash: { danger: "must login to continue!"}
    end
  end

end
