class Admin::UsersController < ApplicationController
  before_action :logged_in_user
  before_action :verify_admin
  
  def index
    @users = User.all
  end
end
