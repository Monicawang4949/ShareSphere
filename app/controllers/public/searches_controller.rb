class Public::SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @q = params[:q]
    @users = User.ransack(name_cont: @q).result
    @posts = Post.ransack(content_cont: @q).result
  end
end
