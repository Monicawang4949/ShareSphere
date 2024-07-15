class Public::SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @q = params[:q]
    if params[:q].present?
      @users = User.ransack(name_cont: @q).result
      @posts = Post.ransack(content_cont: @q).result
    else
      @users = []
      @posts = []
    end
  end
end
