class Public::FavoritesController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_guest_user, only: [:destroy, :create]
  def create
    post = Post.find(params[:post_id])
    favorite = current_user.favorites.new(post_id: post.id)
    favorite.save
    redirect_to request.referer
  end

  def destroy
    post = Post.find(params[:post_id])
    favorite = current_user.favorites.find_by(post_id: post.id)
    favorite.destroy
    redirect_to request.referer
  end

  private

  def ensure_guest_user
    unless current_user.not_guest_user?
      redirect_to request.referer, notice: "ゲストユーザーは閲覧のみでございます"
    end
  end
end
