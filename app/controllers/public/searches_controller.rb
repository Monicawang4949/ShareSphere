class Public::SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @q = params[:q]
    if params[:q].present?
      @users = User.ransack(name_cont: @q).result.page(params[:page]).per(8)
      @posts = Post.ransack(content_cont: @q).result.page(params[:page]).per(10)
      @tags = Tag.ransack(name_cont: @q).result.page(params[:page]).per(12)
    else
      @users = []
      @posts = []
      @tags = []
    end
  end
end
