class Public::CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_guest_user, only: [:destroy, :create]
  def create
    post = Post.find(params[:post_id])
    comment = current_user.comments.new(comment_params)
    comment.post_id = post.id
    comment.save
    redirect_to request.referer
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    redirect_to request.referer
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def ensure_guest_user
    unless current_user.not_guest_user?
      redirect_to request.referer, notice: "ゲストユーザーは閲覧のみでございます"
    end
  end
end
