class RelationshipsController < ApplicationController
  before_action :logged_in_user

  def create
    @user = User.find params[:followed_id]
    current_user.follow @user
    respond_to do |format|
      format.html {redirect_to @user}
      format.js
    end
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow @user
    respond_to do |format|
      format.html {redirect_to @user}
      format.js
    end
  end
  
  def index
    @user = User.find params[:user_id]
    @action = params[:id]
    (@action == "following") ? (@users = @user.following) : (@users = @user.followers)
  end
end

