class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!
  def index
    @posts = Post.all.page(params[:page]).per(10)
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.user
  end

  def user_posts
    @user = User.find(params[:user_id])
    @user_posts = @user.posts.page(params[:page]).per(10)
  end

  def user_favorite_posts
    user = User.find(params[:user_id])
    @user_favorites = user.favorites.page(params[:page]).per(10)
  end

  def tag_posts
    @tag = Tag.find(params[:post_id])
    @tag_posts = @tag.posts.page(params[:page]).per(10)
  end
end
