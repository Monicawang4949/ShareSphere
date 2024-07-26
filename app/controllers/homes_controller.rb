class HomesController < ApplicationController
  def top
    @post = Post.all.sample
    @user = @post.user
    @tags = Tag.order("RANDOM()").limit(5)
  end

  def about
  end
end
