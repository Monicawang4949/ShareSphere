class Admin::RelationshipsController < ApplicationController
  before_action :authenticate_admin!

  def followings
    @user = User.find(params[:user_id])
    @users = @user.followings.page(params[:page]).per(8)
  end

  def followers
    @user = User.find(params[:user_id])
    @users = @user.followers.page(params[:page]).per(8)
  end
end
