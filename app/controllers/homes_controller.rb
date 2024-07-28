class HomesController < ApplicationController
  def top
    @post = Post.all.sample
    @user = @post.user
    if Tag.order("RANDOM()").limit(5).present?
      @tags = Tag.order("RANDOM()").limit(5)
    end
  end

  def about
  end
end
