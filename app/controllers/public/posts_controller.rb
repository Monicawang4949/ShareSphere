class Public::PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]
  before_action :ensure_guest_user, only: [:edit, :update, :destroy, :new, :create]

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    tag_list = params[:post][:tag_name].split(',')
    if @post.save
      @post.save_tags(tag_list)
      redirect_to post_path(@post), notice: "投稿に成功しました"
    else
      render 'new'
    end
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.user
    @comment = Comment.new
  end

  def edit
    @post = Post.find(params[:id])
    @tag_list = @post.tags.pluck(:name).join(',')
  end

  def update
    tag_list = params[:post][:tag_name].split(',')
    if @post.update(post_params)
      @post.save_tags(tag_list)
      redirect_to post_path(@post), notice: "更新に成功しました"
    else
      render "edit"
    end
  end

  def destroy
    @post.destroy
    redirect_to user_path(current_user)
  end

  def user_posts
    user = User.find(params[:user_id])
    @user_posts = user.posts
  end

  def user_favorite_posts
    user = User.find(params[:user_id])
    @user_favorites = user.favorites
  end

  def tag_posts
    @tag = Tag.find(params[:post_id])
    @tag_posts = @tag.posts
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :post_image)
  end

  def ensure_guest_user
    unless current_user.not_guest_user?
      redirect_to request.referer, notice: "ゲストユーザーは閲覧のみでございます"
    end
  end

  def ensure_correct_user
    @post = Post.find(params[:id])
    unless @post.user == current_user
      redirect_to root_path
    end
  end
end
