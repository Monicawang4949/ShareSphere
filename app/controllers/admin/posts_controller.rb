class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.user
  end

  def user_posts
    @user = User.find(params[:user_id])
    @user_posts = @user.posts
  end

  def user_favorite_posts
    user = User.find(params[:user_id])
    @user_favorites = user.favorites
  end
end
