class Admin::SearchesController < ApplicationController
  before_action :authenticate_admin!

  def search
    @q = params[:q]
    @users = User.ransack(name_cont: @q).result
    @posts = Post.ransack(content_cont: @q).result
  end
end
