class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper
  
  private
  def verify_admin
    unless current_user.admin?
      flash[:danger] = t "verify_admin"
      redirect_to root_path
    end
  end
end
