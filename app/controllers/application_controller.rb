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
  
  def load_object model
    object = model.find_by params[:id]
    unless object
      flash[:danger] = t "object_not_found", object: model, id: params[:id]
      redirect_to :back
    end
    object
  end
end
