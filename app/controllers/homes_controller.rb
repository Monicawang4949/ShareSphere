class HomesController < ApplicationController
  def top
    @post = Post.all.sample
    @user = @post.user
    if Tag.all.sample(4).present?
      @tags = Tag.all.sample(4)
    end
  end

  def about
  end
end
