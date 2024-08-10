class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @users = User.all.page(params[:page]).per(6)
  end

  def show
    @user = User.find(params[:id])
    @latest_post = @user.posts.order(created_at: :desc).first
    latest_favorite = @user.favorites.order(created_at: :desc).first
    unless latest_favorite.blank?
      @latest_favorite_post = latest_favorite.post
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_user_path(@user), notice: "変更が保存されました"
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:user_status)
  end
end
