class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  private
  
  def require_signin!
    if current_user.nil?
      flash[:notice] = "You need to sign in to do this"
      redirect_to signin_path
    end
  end
  
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user
  
  def authorize_admin!
    require_signin!
    
    unless current_user.admin
      flash[:alert] = "You must be an admin to do that"
      redirect_to root_path
    end
  end
end
