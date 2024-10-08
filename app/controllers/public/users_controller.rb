class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:update, :edit]
  before_action :ensure_guest_user, only: [:update, :edit]

  def show
    @user = User.find(params[:id])
    @latest_post = @user.posts.order(created_at: :desc).first
    latest_favorite = @user.favorites.order(created_at: :desc).first
    unless latest_favorite.blank?
      @latest_favorite_post = latest_favorite.post
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "変更が保存されました"
    else
      render :edit
    end
  end

  def index
    @users = User.all.page(params[:page]).per(8)
  end

  def settings
    @user = current_user
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image, :email, :profile_is_released)
  end

  def ensure_guest_user
    unless current_user.not_guest_user?
      redirect_to root_path, notice: "ゲストユーザーは閲覧のみなので遷移できません"
    end
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end
